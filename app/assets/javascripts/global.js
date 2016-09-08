function toggleAll(divs) {
	for (var i = 0; i < divs.length; i++) {
	  	if (divs[i].style.display === "none") {
	    	divs[i].style.display = "block";
	  	} else if (divs[i].style.display === "block") {
	    	divs[i].style.display = "none";
	  	} else if (divs[i].style.display === "") {
	    	divs[i].style.display = "block";
		}
	}
}

window.addEventListener("load", function() {

	var searchHelp = document.getElementById("searchHelp");
	var searchHelp__title = document.getElementsByClassName("searchHelp__title");
	var searchHelp__message = document.getElementsByClassName("searchHelp__message");

	searchHelp.addEventListener("click", function(){

		toggleAll(searchHelp__title);
		toggleAll(searchHelp__message);

	});

	var dataHelp = document.getElementById("dataHelp");
	var dataHelp__title = document.getElementsByClassName("dataHelp__title");
	var dataHelp__message = document.getElementsByClassName("dataHelp__message");

	dataHelp.addEventListener("click", function(){
		
		toggleAll(dataHelp__title);
		toggleAll(dataHelp__message);
			
	});

	var getResults = document.getElementById("getResults");
	var twitterHandle = document.getElementById("twitterHandle")
	var errorMessage = document.getElementById("errorMessage");

	getResults.addEventListener("click", function(){

		if (twitterHandle.value === "") {

			errorMessage.innerHTML = "Oops. You didn't enter any information";

		} else {

		}

	});
});