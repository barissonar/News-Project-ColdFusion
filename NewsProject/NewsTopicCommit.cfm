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


      
      <cfif isDefined('form.action') and form.action eq "add">
          
      
      
          <cfif form.topic neq "" and form.slugtopic neq "">

           <cfobject type="component" name="obj" component="functions">

          
               <cfoutput>#obj.AddNewsTopic(form.topic,form.slugtopic)#</cfoutput>
            
   

             
  
          <cfelse>

              <p>Lütfen Tüm alanları doldurunuz.</p>
             
          </cfif>
          
          
      </cfif>
      
      
      <cfif isDefined('form.action') and form.action eq "update">
      
        <cfif form.topic neq "" and form.slugtopic neq "">
           <cfobject type="component" name="obj" component="functions">

       

          <cfoutput>#obj.UpdateNewsTopic(form.actionid,form.topic,form.slugtopic)#</cfoutput>

         
           
         <cfelse> 
           <p>Lütfen Tüm alanları doldurunuz.</p>   
         </cfif>    
         
      </cfif>
      
      
      
      
      <cfif isDefined("url.idupdate")>
      
             <cfquery datasource="#dbName#" username="#username#" password="#password#" name="updatelist">
              SELECT *
              FROM NewsTopic
              WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.idupdate#">
             </cfquery>
      
      
            
      
             <cfoutput query="updatelist">
                <section class="my-5">
              
                  <div class="container col-6 py-5">
              
                      <div class="row"> 
              
                        <div class="col-12">
      
                           <form action="NewsTopicCommit.cfm" method="post">
      
                               <div class="mb-3 text-center py-3">
      
                                  <cfoutput> <h2 class="fw-bold">HABER KONU ID : #updatelist.id#</h1> </cfoutput>
                                  <input type="hidden" name="actionid" value="#updatelist.id#">
      
                               </div>
              
                              <div class="mb-3">
                                  <label for="topic" class="form-label">Haber Konusu</label>
                                <cfoutput>  <input type="text" class="form-control" id="topic" name="topic" value="#updatelist.topic#"></cfoutput>
                              </div>
      
      
      
                               <div class="mb-3">
                                  <label for="slugtopic" class="form-label">Slug (URL)</label>
                             <cfoutput>  <input type="text" class="form-control" id="slugtopic" name="slugtopic" value="#updatelist.slug#"> </cfoutput>
                                </div>
      
                              <div class="text-center py-4 my-5 bg-color-gray"> 
      
                                  <input type="submit" class="btn btn-primary" value="GÜNCELLE">
                                  <input type="hidden" name="action" value="update">
      
                                
      
                              </div>
                              
              
                            </form>
                              
                          </div>
              
                      </div>
              
                  </div>   
      
              </section>
             </cfoutput>
            
      
      </cfif>
      
      
         <cfif isDefined("url.iddelete")>
             
         
             <cfparam name="url.iddelete" default="">
         
             <cfif url.iddelete neq "">
         
              <cfobject type="component" name="obj" component="functions">
            
              <cfoutput>#obj.DeleteNewsTopic(url.iddelete)#</cfoutput>
            
         
             <cfelse> 
         
              <p>Lütfen Tüm alanları doldurunuz.</p>   
         
           </cfif>    
                 
         
         </cfif>
      
      
         
   
   

      

     
       
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> 
 </body>
   
</html>


