
document.addEventListener("DOMContentLoaded", function() {

    document.getElementById("idupdate").addEventListener("change", function() {
        
    
        let selectValue = document.getElementById("idupdate").value;
       
        document.getElementById("dynamicurl").href = "NewsTopicCommit.cfm?idupdate=" + selectValue;
    
    
      });

  });


   

