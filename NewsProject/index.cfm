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
    <cfprocessingdirective pageEncoding="utf-8">


       
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
   
   <div id="carouselExampleCaptions" class="carousel slide text-center mt-3 bg-primary d-none d-md-block" style="height: 400px" >
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>

     <cfset dateNow=Now()>  

     <cfquery name="NewsCarouselGet" datasource="#dbName#" username="#username#" password="#password#">
            
         SELECT *
         FROM NewsContent
         WHERE datetime >= DATEADD(DAY, -3, <cfqueryparam value="#dateNow#" cfsqltype="cf_sql_timestamp">);    
          
     </cfquery>
           
        <div class="carousel-inner">

         <cfoutput query="NewsCarouselGet">

          <cfquery name="NewsCarouselGetSlug" datasource="#dbName#" username="#username#" password="#password#">
              
              SELECT slug FROM NewsTopic WHERE id = <cfqueryparam value="#NewsCarouselGet.NewsTopicID#" cfsqltype="cf_sql_integer">

          </cfquery>      

            <a href="NewsByCategory.cfm?slug=#NewsCarouselGetSlug.slug#" style="">
               <div class="carousel-item  <cfif #NewsCarouselGet.currentRow# eq 1>active</cfif>">
                 <img height='400px' src="#NewsCarouselGet.image#" alt='Görüntü Yüklenemedi' title="#NewsCarouselGet.Header#">
                 <div class="carousel-caption d-none d-md-block text-primary">
                   <h5 >#NewsCarouselGet.Header#</h5>
                   <p >#NewsCarouselGet.Content#</p>
                 </div>
               </div>
            </a>
          
         </cfoutput>  
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
</div>




  
            <cfquery datasource="#dbName#" username="#username#" password="#password#" name="NewsAllGet">
       
                    SELECT * FROM NewsContent ORDER BY datetime DESC;
       
             </cfquery>
       
             
                 
                    
                   
            <section class="container text-center col-12 pt-5 mt-5">

              <span><i class="fa-solid fa-newspaper fa-2xl"></i></span>  
              <h1 class="display-3 py-4 ">Tüm Haberler</h1>
                    
                <div class="row my-5 py-5  ps-5 ps-xl-0 ">

                   <cfoutput query="NewsAllGet"> 
              
                       <div class="col-12 col-md-6 col-xl-4 text-center zoom-effect mt-5 py-3">
      
                         <a href="NewsDetail.cfm?id=#NewsAllGet.id#" class="text-decoration-none">
                            <div class="card" style="width: 18rem;">
                              <img src="#NewsAllGet.image#" class="card-img-top img-fluid" alt="Resim Yüklenemedi" title="#NewsAllGet.Header#">
                              <div class="card-body">
                                <p class="card-text">#NewsAllGet.Header#</p>
                              </div>
                            </div>
                         </a> 
                       </div>  
                         

                   </cfoutput>     

                     

                </div>               
                 
              </section>
  
             
       










   

      

     
       
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> 
 </body>
   
</html>


