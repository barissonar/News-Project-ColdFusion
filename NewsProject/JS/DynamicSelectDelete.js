
document.addEventListener("DOMContentLoaded", function() {

    document.getElementById("iddelete").addEventListener("change", function() {
        
    
        let selectValue = document.getElementById("iddelete").value;
       
        document.getElementById("dynamicurl").href = "NewsTopicCommit.cfm?iddelete=" + selectValue;
    
    
      });

  });


   

