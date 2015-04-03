// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.onload = function(){
  
  document.getElementById("searchinfo").addEventListener("click", function(){
    if (document.getElementById("searchinfobox").style.display === "none") {
      document.getElementById("searchinfobox").style.display = "block";
      document.getElementById("searchbox").style.height = "450px";
    } else {
      document.getElementById("searchinfobox").style.display = "none";
      document.getElementById("searchbox").style.height = "225px";
    }
  });
  
  
  document.getElementById("addinfo").addEventListener("click", function(){
    if (document.getElementById("addinfobox").style.display === "none") {
      document.getElementById("addinfobox").style.display = "block";
      document.getElementById("infobox").style.height = "550px";
    } else {
      document.getElementById("addinfobox").style.display = "none";
      document.getElementById("infobox").style.height = "225px";
    }
  });
  
  document.getElementById("menu").addEventListener("click", function(){
    if (document.getElementById("menuList").style.display === "none") {
      document.getElementById("menuList").style.display = "block";
      document.getElementById("menuClicked").style.backgroundColor = "rgba(265,265,265,1)";
      document.getElementById("menu").src = "/assets/menudark.png";
    } else {
      document.getElementById("menuList").style.display = "none";
      document.getElementById("menuClicked").style.backgroundColor = "rgb(0, 204, 255)";
      document.getElementById("menu").src = "/assets/menu.png";
    }
  });
  
  
}