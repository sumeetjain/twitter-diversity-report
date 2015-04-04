// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.onload = function(){
  
  // document.getElementById("menu").addEventListener("click", function(){
  //   if (document.getElementById("menuList").style.display === "none") {
  //     document.getElementById("menuList").style.display = "block";
  //     document.getElementById("menuClicked").style.backgroundColor = "rgba(265,265,265,1)";
  //     document.getElementById("menu").src = "/assets/menudark.png";
  //   } else {
  //     document.getElementById("menuList").style.display = "none";
  //     document.getElementById("menuClicked").style.backgroundColor = "";
  //     document.getElementById("menu").src = "/assets/menu.png";
  //   }
  // });
  
  document.getElementById("searchinfo").addEventListener("click", function(){
    if (document.getElementById("searchinfobox").style.display === "none") {
      document.getElementById("searchinfobox").style.display = "block";
      document.getElementById("searchbox").style.height = "585px";
    } else {
      document.getElementById("searchinfobox").style.display = "none";
      document.getElementById("searchbox").style.height = "300px";
    }
  });
  
  
  document.getElementById("addinfo").addEventListener("click", function(){
    if (document.getElementById("addinfobox").style.display === "none") {
      document.getElementById("addinfobox").style.display = "block";
      
 
      if (window.matchMedia("(min-width: 994px)").matches) {
        document.getElementById("infobox").style.height = "670px";
      } else if (window.matchMedia("(min-width: 965px)").matches) {
        document.getElementById("infobox").style.height = "745px";
      } else if (window.matchMedia("(min-width: 814px)").matches) {
        document.getElementById("infobox").style.height = "860px";
      } else if (window.matchMedia("(min-width: 770px)").matches) {
        document.getElementById("infobox").style.height = "975px"; 
      } else if (window.matchMedia("(min-width: 663px)").matches) {
        document.getElementById("infobox").style.height = "1075px";
      } else if (window.matchMedia("(min-width: 500px)").matches) {
        document.getElementById("infobox").style.height = "1100px";
      } 
      
  } else {
      document.getElementById("addinfobox").style.display = "none";
      document.getElementById("infobox").style.height = "300px";
    }
  });
  
  
}

