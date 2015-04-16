// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.onload = function(){
  
  document.getElementById("methodology").addEventListener("click", function(){
    if (document.getElementById("methodologyinfobox").style.display === "none") {
      document.getElementById("methodologyinfobox").style.display = "block";
    } else {
      document.getElementById("methodologyinfobox").style.display = "none";
    }
  });
  
};
