<!--- Please insert your code here --->
<!doctype html>
<html lang="tr">
    <head>
       
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>News</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="fontawesome/css/all.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;1,100&display=swap" rel="stylesheet">
        
    </head>
   
 <body>
    
    <cfprocessingdirective pageEncoding="utf-8">
    <cfset dbName = "NewsProjectDB">
    <cfset username = "sa">
    <cfset password = "12345">


       
    <nav class="navbar navbar-expand-lg bg-body-tertiary py-3 px-5">
        <div class="container-fluid">
           <a class="navbar-brand" href="index.cfm"><img height= "60px" title="WaternetHaber Anasayfa" src="img/news-logo.jpg"></a>
           <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
             <span class="navbar-toggler-icon"></span>
           </button>
           <div class="collapse navbar-collapse" id="navbarNavDropdown">
             <ul class="navbar-nav">
               <li class="nav-item dropdown ms-lg-4">
                 <a class="nav-link" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                   <i class="fa-solid fa-bars fa-xl" title="Haber Konulari"></i>
                 </a>
                 <ul class="dropdown-menu">

                   <cfquery name="NewsTopicAll" datasource="#dbName#" username="#username#" password="#password#">
                           SELECT *
                           FROM NewsTopic
                   </cfquery>

                   <cfoutput query="NewsTopicAll">     

                      <li><a class="dropdown-item" href="NewsByCategory.cfm?slug=#NewsTopicAll.slug#">#NewsTopicAll.topic#</a></li>

                    </cfoutput>
                   
                 </ul>
               </li>
               <li class="nav-item ms-lg-4">
                 <a class="nav-link text-primary" aria-current="page" href="AddNewsContent.cfm"><i class="fa-solid fa-plus fa-sm"></i> Haber Ekle</a>
               </li>
               <li class="nav-item ms-lg-3">
                 <a class="nav-link text-primary" href="AddNewsTopic.cfm"><i class="fa-solid fa-plus fa-sm"></i> Haber Konusu Ekle</a>
               </li>

             </ul>
           </div>
         </div>
    </nav>

      <cfquery name="NewsTopicAll" datasource="#dbName#" username="#username#" password="#password#">

                SELECT *
                FROM NewsTopic

         </cfquery>

        <section class="my-5">
            <br>
            <div class="container col-6 py-5">
        
                <div class="row"> 
        
                  <div class="col-12">
                     <form action="NewsTopicCommit.cfm" method="post">
                        
                        <div class="mb-3 text-center py-2">
      
                            <h2 class="fw-bold mb-4">HABER KONUSU GÜNCELLE</h2> 
              
      
                        </div>
        
                        <select name="idupdate" id="idupdate" class="form-select" size="3" aria-label="Size 3 select example">
                        
                               <option selected>Lütfen bir konu seçiniz.</option>

                               <cfoutput query="NewsTopicAll">
                                  <option value="#NewsTopicAll.id#">#NewsTopicAll.topic#</option>
                               </cfoutput>
                              
                        </select>

                        <div class="text-center py-4 my-5 bg-color-gray"> 

                            <a href="" id="dynamicurl" class="btn btn-primary" style="width:100px">GÜNCELLE</a>
                          

                        </div>
                        
        
                      </form>
                        
                    </div>
        
                </div>
        
            </div>   

        </section>



   
   

      

     
       
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> 
    <script src="JS/DynamicSelectUpdate.js"></script>
 </body>
   
</html>


