class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :usta_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :usta_id, presence: true

  #has_many :players
  has_one :player
  
  has_many :friendships
  has_many :friends, :through => :friendships
  
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  after_create :get_usta_data

  # def player
  #   self.players.where(primary: "active").first
  # end

  def is_a_friend(user)
    if self.friendships.where(friend_id: user.id).first && self.inverse_friendships.where(friend_id: self.id, user_id: user.id).first
      return true
    end
  end

  def get_usta_data
    unless self.player
     if self.first_name && self.last_name
      a = Mechanize.new
      first_name = self.first_name
      last_name = self.last_name

      page = a.get("https://tennislink.usta.com/Tournaments/Rankings/RankingHome.aspx?FirstName=#{first_name}&MiddleName=&LastName=#{last_name}&Type=Ranking&Year=")

      id = page.search("//span[@id='ctl00_mainContent_grdMain_ctl02_lblPlayerName']/a").attr('href').to_s.split("PlayerId=").last.split("%3d")[0].gsub('%2b','+').gsub('%2f','/')

      if player = Player.where(:usta_id => id, :user_id => nil).first
        player.user_id = self.id
        player.save
        my_player = player
      elsif Player.where(:usta_id => id).first == nil
        my_player = Player.create(:usta_id => id, :user_id => self.id, :name => last_name.downcase + ', ' + first_name.downcase)
      end

      url = "https://tennislink.usta.com/Tournaments/Rankings/RankingHome.aspx?"

      params = {
        "FirstName" => "lexi",
        "LastName" => "bari",
        "Type" => "Ranking",
        "__EVENTTARGET" => "ctl00_mainContent_PlayerRecord_UpdatePanel",
        "__EVENTARGUMENT" => "Sender=lbtViewPlayerRecords&StartDt=8/1/2004&EndDt=4/16/2014&PlayerID=#{id}=="
      }

      headers = {
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip,deflate,sdch",
        "Accept-Language" => "en-US,en;q=0.8,da;q=0.6,es;q=0.4,fi;q=0.2",
        "Cache-Control" => "no-cache",
        "Connection" => "keep-alive",
        "Cookie" => "ASP.NET_SessionId=abaauhq15b1atuc02vamne40; __qca=P0-635349534-1394991767304; SearchCondition=Team_Year=2014&Team_ProgramType=1&Team_ID=&Team_TeamNam=&Team_TeamNumber=&Team_MatchNumber=&City=&Champ_Section=&Champ_District=&Champ_Area=&Champ_Program=&Team_Section=-1&Champ_Level=-1&Team_FirstName=lexi&Team_LastName=bari&SearchType=SearchStatsAndStandings; ClassicUI=false; BigIPCookie=3608442634.47873.0000; __utma=248698626.1240417725.1394991767.1394991767.1394991767.1; __utmb=248698626.28.10.1394991767; __utmc=248698626; __utmz=248698626.1394991767.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); s_sess=%20s_cc%3Dtrue%3B%20SC_LINKS%3Dtlink%253Atourn%253Afind%2520a%2520ranking%253Aplayer%2520rankings%255E%255EBari%252C%2520Lexi%255E%255Etlink%253Atourn%253Afind%2520a%2520ranking%253Aplayer%2520rankings%2520%257C%2520Bari%252C%2520Lexi%255E%255E%3B%20s_sq%3Dustatennislinkprod%252Canustatennislinkprod%253D%252526pid%25253Dtlink%2525253Atourn%2525253Afind%25252520a%25252520ranking%2525253Aplayer%25252520rankings%252526pidt%25253D1%252526oid%25253Djavascript%2525253A__doPostBack%25252528%25252522ctl00_mainContent_PlayerRecord_UpdatePanel%25252522%2525252C%25252520%25252522Sender%2525253DlbtViewPlayerRecords%25252526S%252526ot%25253DA%3B",
        "Host" => "tennislink.usta.com",
        "Origin" => "https://tennislink.usta.com",
        "X-Requested-With" => "XMLHttpRequest"
      }

      page = a.post(url, params, headers)

      info_row = page.search("//div[@class='player_specs']/table/tr")[1]
      if info_row
        info_detail = {}
          [
            [:date_range, 'td[2]/text()'],
            [:overall_record, 'td[3]/text()'],
            [:location, 'td[4]/text()']
          ].each do |name, xpath|
            info_detail[name] = info_row.at_xpath(xpath).to_s.strip
          end
        my_player.date_range = info_detail[:date_range]
        my_player.overall_record = info_detail[:overall_record]
        my_player.location = info_detail[:location]
        my_player.save
      end

      page.search("//div[@class='CommonTable top-margin']").each do |table|
        t_id = table.css("span.event_title/a").to_s.split('ViewDraw(').last.split(',').first
        t_link = "http://tennislink.usta.com/Tournaments/TournamentHome/Tournament.aspx?T=" + t_id
        t_name = table.css("span.event_title/text()").to_s.gsub(/^$\n/, '').strip
        t_date = table.css("span.event_date/text()").to_s.gsub(/^$\n/, '').strip
        rows = table.css("tr")
        details = rows.collect do |row|
          detail = {}
          [
            [:opponent, 'td[3]/a/text()'],
            [:opponent_usta_id, 'td[3]/a'],
            [:result, 'td[2]/text()'],
            [:score, 'td[4]/text()']
          ].each do |name, xpath|
            detail[name] = row.at_xpath(xpath).to_s.strip
          end
          detail
        end
        details.each do |d|
          if d
            unless d[:opponent] == ""
              opponent_usta_id = d[:opponent_usta_id].split("PlayerID=").last.split("%3d")[0].gsub('%2b','+').gsub('%2f','/')
              unless player = Player.where(:usta_id => opponent_usta_id).first
                player = Player.create(:usta_id => opponent_usta_id, :name => d[:opponent].downcase)
                player.get_other_player_info
              end
              unless Match.where(:player1_id => my_player.id, :player2_id => player.id, :score => d[:score]).first || Match.where(:player1_id => player.id, :player2_id => my_player.id, :score => d[:score]).first
                Match.create(:player1_id => my_player.id, :player2_id => player.id, :result => d[:result], :score => d[:score], :name => t_name, :link => t_link, :date => t_date)
              end
            end
          end
        end
      end
     end
    end
  end


  handle_asynchronously :get_usta_data
  
end
