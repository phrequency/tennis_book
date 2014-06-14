module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def usta_sections
  	[
  		["Caribbean", "Caribbean"],
		["Eastern", "Eastern"],
		["Florida", "Florida"],
		["Foreign", "Foreign"],
		["Hawaii Pacific", "Hawaii Pacific"],
		["Intermountain", "Intermountain"],
		["Mid-Atlantic", "Mid-Atlantic"],
		["Middle States", "Middle States"],
		["Midwest", "Midwest"],
		["Missouri Valley", "Missouri Valley"],
		["New England", "New England"],
		["Northern California", "Northern California"],
		["Northern", "Northern"],
		["Pacific Northwest", "Pacific Northwest"],
		["Southern California", "Southern California"],
		["Southern", "Southern"],
		["Southwest", "Southwest"],
		["Texas", "Texas"]
  	]
  end

  def usta_districts(section)
  	if section == "Caribbean"
  		[
  			["Puerto Rico"],
			["Virgin Islands"]
  		]
  	elsif section == "Eastern"
  		[
			["Western Region"],
			["Metropolitan Region" ],
			["Long Island Region"],
			["Northern Region"],
			["Southern Region"],
			["New Jersey Region"]
  		]
  	elsif section == "Florida"
  		[
			["Region 1"],
			["Region 2"],
			["Region 3"],
			["Region 4"],
			["Region 5"],
			["Region 6"],
			["Region 7"],
			["Region 8"]
  		]
  	elsif section == "Foreign"
  		[
			["Foreign"],
  		]
  	elsif section == "Hawaii Pacific"
  		[
			["East Hawaii"],
			["Kauai"],
			["Maui"],
			["Oahu"],
			["American Samoa-Guam"],
			["West Hawaii"]
  		]
  	elsif section == "Intermountain"
  		[
  			["Southern Nevada"],
			["Colorado"],
			["Idaho"],
			["Montana"],
			["Utah"],
			["Wyoming"]
  		]
  	elsif section == "Mid-Atlantic"
  		[
  			["Delaware"],
			["Central Pennsylvania"],
			["Eastern Pennsylvania"],
			["Philadelphia"],
			["Allegheny Mountain"],
			["New Jersey"]
  		]
  	elsif section == "Midwest"
  		[
  			["Central Indiana"],
			["Chicago"],
			["N.E. Michigan"],
			["S.E. Michigan "],
			["Western Michigan"],
			["Northern Indiana"],
			["Ohio Valley"],
			["Northeastern Ohio"],
			["Northwestern Ohio"],
			["Wisconsin"],
			["Northern Michigan"],
			["Mid-South Illinois"]
  		]
  	elsif section == "Missouri Valley"
  		[
  			["Heart of America"],
  			["Iowa"],
  			["Kansas"],
  			["Nebraska"],
  			["Oklahoma"],
  			["St. Louis"],
  			["Missouri"]
  		]
  	elsif section == "New England"
		[
			["New Hampshire"],
			["Vermont"],
			["Eastern Massachusetts"],
			["Western Massachusetts"],
			["Rhode Island"],
			["Connecticut"],
			["Maine"]
		]
	elsif section == "Northern California"
		[
			["Northern California"]
		]
	elsif section == "Northern"
		[
			["Northern"]
		]
	elsif section == "Pacific Northwest"
		[
			["Southern Oregon"],
			["Eastern Washington"],
			["Alaska"],
			["Idaho"],
			["Northern Oregon"],
			["British Columbia"],
			["Southwest Washington"],
			["Northwest Washington"],
		]
	elsif  section == "Southern California"
		[
			["Southern California"],
			["San Diego"]
		]
	elsif section == "Southern"
		[
			["Alabama"],
			["Arkansas"],
			["Georgia"],
			["Kentucky"],
			["Louisiana"],
			["Mississippi"],
			["North Carolina"],
			["South Carolina"],
			["Tennessee"]
		]
	elsif section == "Southwest"
		[
			["Northern Arizona"],
		 	["Northern New Mexico"],
		 	["Southern Arizona"],
		 	["Central Arizona"],
		 	["Greater El Paso"],
		 	["Southern New Mexico"],
		 	["Southeast New Mexico"]
		] 
	elsif section == "Texas"
	[
		["Texas"]
	]
  	end
  end

end
