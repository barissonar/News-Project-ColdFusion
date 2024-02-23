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
   
       
       <cfif isDefined('url.slug')>
       
              <cfquery datasource="#dbName#" username="#username#" password="#password#" name="IdBySlug">
       
                     SELECT * FROM NewsTopic WHERE slug = <cfqueryparam value="#url.slug#" cfsqltype="cf_sql_varchar">
       
              </cfquery>
       
              <cfquery datasource="#dbName#" username="#username#" password="#password#" name="ContentById">
       
                     SELECT * FROM NewsContent WHERE NewsTopicID = <cfqueryparam value="#IdBySlug.id#" cfsqltype="cf_sql_integer">
       
              </cfquery>
       
             


     
                    
                   
              <section class="container text-center col-12 pt-5">

              <span><i class="fa-solid fa-newspaper fa-2xl"></i></span>  
            <cfoutput query="IdBySlug">  <h1 class="display-3 py-4 ">#IdBySlug.topic# Haberleri</h1> </cfoutput>
                    
                <div class="row my-5 py-5 ps-5 ps-xl-0">

                   <cfoutput query="ContentByID"> 
              
                       <div class="col-12 col-md-6 col-xl-4 mt-5 text-center zoom-effect">
                         <a href="NewsDetail.cfm?id=#ContentByID.id#" class="text-decoration-none">
                            <div class="card" style="width: 18rem;">
                              <img src="#ContentByID.image#" class="card-img-top" alt="Resim Yüklenemedi" title="#ContentByID.Header#">
                              <div class="card-body">
                                <p class="card-text">#ContentByID.Header#</p>
                              </div>
                            </div>
                         </a> 
                       </div>  
                         

                   </cfoutput>     

                     

                </div>               
                 
              </section>

              
           <cfelse> 

           <div class="text-center mt-5 py-5 alert alert-danger" role="alert" >İçerik bulunamadı.</div>   
             
       
                   
                       
        
       
       </cfif>
    


 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> 
    </body>

</html>