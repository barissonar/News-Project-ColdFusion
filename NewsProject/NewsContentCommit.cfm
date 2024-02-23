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
    <cfparam name="form.newstopicid"  default="">

    <cfif form.newstopicid neq "" and form.header neq "" and form.content neq "" and form.slugcontent neq "" and form.fileToUpload neq "">
       
       <cfparam name="form.fileToUpload" default="">

       <cfif isDefined("form.fileToUpload") and form.fileToUpload neq "">

          <cfset uploadPath = "uploadsimg/">
          <cfset uniqueFileName = createUUID() & ".jpg">
          <cfset destinationPath = expandPath(uploadPath & uniqueFileName)>
      
           <!-- Resmi belirlenen yola kaydet -->
          <cffile action="upload" filefield="fileToUpload" destination="#destinationPath#">

        </cfif>

        <cfset imgpathDB = uploadPath & uniqueFileName>

        <cfobject type="component" name="obj" component="functions">


        <cfoutput>#obj.AddNewsContent(form.newstopicid,form.header,form.content,form.slugcontent,imgpathDB)#</cfoutput>

     

        
      
         
    <cfelse>
       
        <p>Lütfen tüm alanları girin</p>
               
    </cfif>
    
    
</cfif>


<cfif isDefined('form.action') and form.action eq "update">

<cfparam name="form.newstopicid"  default="">
    
<cfif form.actionid neq "" and form.newstopicid neq "" and form.header neq "" and form.content neq "" and form.slugcontent neq "">

    <cfparam name="form.fileToUpload" default="">

    <cfif isDefined("form.fileToUpload") and form.fileToUpload neq "">

        <cfif isDefined('form.imagepath') and form.imagepath neq "">

          <cfset uploadPath = "uploadsimg/">
          <cfset uniqueFileName = createUUID() & ".jpg">
          <cfset destinationPath = expandPath(uploadPath & uniqueFileName)>
          <cfset filePath = expandPath(form.imagepath)>
          <cfset imgpathDB = uploadPath & uniqueFileName>

         <cfif directoryExists(getDirectoryFromPath(filePath))>
          
             <cfif fileExists(filePath)>
                  <cfobject type="component" name="obj" component="functions">
                  <cfoutput>#obj.UpdateNewsContent(form.actionid,form.newstopicid,form.header,form.content,form.slugcontent,imgpathDB)#</cfoutput>
                  <cffile action="delete" file="#filePath#">
                  <cfoutput>Eski resim silindi: #filePath#</cfoutput>
                  <cffile action="upload" filefield="fileToUpload" destination="#destinationPath#">
                  <cfoutput>Yeni resim Eklendi: #destinationPath#</cfoutput>
             <cfelse>
                 <cfoutput>Dosya bulunamadı: #filePath# Lğtfen güncelleme sayfasını yenileyip tekrar deneyin.</cfoutput>
             </cfif>

         <cfelse>
             <cfoutput>Dizin bulunamadı: #getDirectoryFromPath(filePath)#</cfoutput>
         </cfif>
        
        </cfif>   

    <cfelseif form.fileToUpload eq "">

         <cfobject type="component" name="obj" component="functions">         
         <cfoutput>#obj.UpdateNewsContent(form.actionid,form.newstopicid,form.header,form.content,form.slugcontent)#</cfoutput>

    </cfif>

    
    
<cfelse>
    <p>Lütfen tüm alanlari girin</p>   
    
</cfif>
</cfif>


<cfif isDefined("url.idupdate")>


       <cfquery datasource="#dbName#" username="#username#" password="#password#" name="updatelist">
        SELECT *
        FROM NewsContent
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.idupdate#">
       </cfquery>

       <cfquery name="NewsTopicAll" datasource="#dbName#" username="#username#" password="#password#">
         SELECT *
         FROM NewsTopic
       </cfquery>

<section>        
   <cfloop query="updatelist">
    <div class="container col-6">
      <div class="row">
       <div class="col-12">
        <form action="NewsContentCommit.cfm" method="post" enctype="multipart/form-data" class="mt-5">
          
            <div class="mb-3 text-center py-3">
            <cfoutput> <h2 class="fw-bold">HABER ID : #updatelist.id#</h1> </cfoutput>
            </div>

            <cfoutput>
               <input type="hidden" name="actionid" value="#updatelist.id#">
            </cfoutput>

            <div class="mb-3">
                <label for="newstopicid" class="form-label">Haber Konusu</label>
                <select id="newstopicid" name="newstopicid" class="form-select" size="3" aria-label="Size 3 select example">
                  <cfoutput query="NewsTopicAll">
                     <option value="#NewsTopicAll.id#" <cfif NewsTopicAll.id eq updatelist.NewsTopicID>selected</cfif>> #NewsTopicAll.topic# </option>
                  </cfoutput>   
                </select>
            </div>

            <div class="mb-3">
                 <label for="header" class="form-label">Haber Basligi</label>
                 <cfoutput><input type="text" name="header" class="form-control" id="header" value="#updatelist.Header#"></cfoutput>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">Haber içerigi</label>
             <cfoutput> <textarea class="form-control" id="content" name="content" rows="3">#updatelist.Content#</textarea> </cfoutput>
            </div>

            <div class="mb-3">
                 <label for="slugcontent" class="form-label">Haber Slug ( url )</label>
                 <cfoutput><input type="text" name="slugcontent" class="form-control" id="slugcontent" value="#updatelist.slug#"></cfoutput>
            </div>

            <div class="mb-3">
                 <label for="fileToUpload" class="form-label">Haber Resmi</label>
                 <input class="form-control" name="fileToUpload" type="file" id="fileToUpload" accept='image/*' >
            </div>
              
            <cfoutput>
               <input type="hidden" name="imagepath" value="#updatelist.image#">
            </cfoutput>

            <div class="d-flex justify-content-around py-4 my-5 bg-color-gray"> 
               <input type="submit" value="Güncelle" class="btn btn-success" style="width:100px">
               <input type="hidden" name="action" value="update">
   
               <cfoutput>
                   <a class="btn btn-danger " style="width:100px" href="NewsContentCommit.cfm?iddelete=#updatelist.id#">SİL</a>
               </cfoutput>  
            </div>



          
        </form>
    
       </div> 
      </div>  
       
    </div>
   </cfloop>

</section>
      

</cfif>


<cfif isDefined("url.iddelete")>


    <cfquery name="DelContentimg" datasource="#dbName#" username="#username#" password="#password#">

        SELECT image FROM NewsContent WHERE id = <cfqueryparam  value="#url.iddelete#" cfsqltype="cf_sql_integer">

    </cfquery>

    <cfquery name="HasContent" datasource="#dbName#" username="#username#" password="#password#">

        SELECT * FROM NewsContent WHERE id = <cfqueryparam  value="#url.iddelete#" cfsqltype="cf_sql_integer">

    </cfquery>

    <cfif HasContent.recordCount neq 0>    
    
         <cfset slug= DelContentimg.image>
         <cfobject type="component" name="obj" component="functions">
         <cfoutput>#obj.DeleteNewsContent(url.iddelete)#</cfoutput>
         <cfset filePath = expandPath(slug)>
         <cffile action="delete" file="#filePath#">

    <cfelse>
         <cfoutput>Bu Haber zaten silinmiş.</cfoutput>
    </cfif>
    
    

    

</cfif>



  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> 

</body>




</html>