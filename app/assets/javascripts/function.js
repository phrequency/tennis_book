jQuery( document ).ready(function( $ ) {

	 $(".text").typed({
            strings: ["We're loading your player results!", "Please refresh this page in a few moments..."],
            typeSpeed: 20, // typing speed
            backDelay: 1500, // pause before backspacing
            loop: true, // loop on or off (true or false)
            loopCount: false, // number of loops, false = infinite
            callback: function(){ } // call function after typing is done
        });

  // Code using $ as usual goes here.
});