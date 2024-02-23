<cfcomponent>
    <cfset dbName = "NewsProjectDB">
    <cfset username = "sa">
    <cfset password = "12345">

   <cffunction name="AddNewsTopic" returntype="string" access="remote">

    <cfargument name="topic" type="string" required="false">
    <cfargument name="slugtopic" type="string" required="false" >

    <cfquery datasource="#dbName#" username="#username#" password="#password#" name="IsHasSlug">

      SELECT * FROM NewsTopic WHERE LOWER(slug) = LOWER(<cfqueryparam value='#arguments.slugtopic#' cfsqltype='cf_sql_varchar'>);

    </cfquery>

    <cfquery datasource="#dbName#" username="#username#" password="#password#" name="IsHasTopic">

      SELECT * FROM NewsTopic WHERE LOWER(topic) = LOWER(<cfqueryparam value='#arguments.topic#' cfsqltype='cf_sql_varchar'>)

    </cfquery>

    <cfset result = "">

    <cfif IsHasSlug.recordCount neq 0>

    
   
      <cfset result = result & "<div class='alert alert-danger text-center mt-5' role='alert'>
        <i class='fa-solid fa-xmark text-danger'></i> Bu isme sahip bir slug zaten var.
      </div>" />

    </cfif>
    <cfif IsHasTopic.recordCount neq 0>

         <cfset result = result & "<div class='alert alert-danger text-center mt-5' role='alert'>
        <i class='fa-solid fa-xmark text-danger'></i> Bu isme sahip bir Konu zaten var.
      </div>" />

    </cfif>
    <cfif IsHasSlug.recordCount eq 0 and IsHasTopic.recordCount eq 0>

      <cfquery datasource="#dbName#" username="#username#" password="#password#">

        INSERT INTO NewsTopic (topic,slug)
        VALUES ('#arguments.topic#','#arguments.slugtopic#')

      </cfquery>

      

      <cfset result = "<div class='alert alert-success text-center mt-5' role='alert'>
          Haber Konusu Başarıyla Eklendi.
      </div>">

    </cfif>

    <cfreturn result>

    

  </cffunction>

  <cffunction name="UpdateNewsTopic" returntype="string" access="remote" >

   <cfargument name="id" type="integer" required="false">   
   <cfargument name="topic" type="string" required="false">
   <cfargument name="slugtopic" type="string" required="false">
   

   <cfquery datasource="#dbName#" username="#username#" password="#password#" name="IsHasSlug">

     SELECT * FROM NewsTopic
     WHERE LOWER(slug) = LOWER(<cfqueryparam value='#arguments.slugtopic#' cfsqltype='cf_sql_varchar'>)
     AND id != <cfqueryparam value='#arguments.id#' cfsqltype='cf_sql_integer'>;

   </cfquery>

   <cfquery datasource="#dbName#" username="#username#" password="#password#" name="IsHasTopic">

     SELECT * FROM NewsTopic
     WHERE LOWER(topic) = LOWER(<cfqueryparam value='#arguments.topic#' cfsqltype='cf_sql_varchar'>)
     AND id != <cfqueryparam value='#arguments.id#' cfsqltype='cf_sql_integer'>;

   </cfquery>

   <cfset result = "">

   <cfif IsHasSlug.recordCount neq 0>
   
      <cfset result = result & "<div class='alert alert-danger text-center mt-5' role='alert'>
        <i class='fa-solid fa-xmark text-danger'></i> Bu isme sahip bir slug zaten var.
      </div>" />

   </cfif>
   <cfif IsHasTopic.recordCount neq 0>

      <cfset result = result & "<div class='alert alert-danger text-center mt-5' role='alert'>
        <i class='fa-solid fa-xmark text-danger'></i> Bu isme sahip bir konu zaten var.
      </div>" />

   </cfif>

   <cfif IsHasSlug.recordCount eq 0 and IsHasTopic.recordCount eq 0>

   <cfquery datasource="#dbName#" username="#username#" password="#password#">

        UPDATE NewsTopic
        SET 
        topic = <cfqueryparam value="#arguments.topic#" cfsqltype="cf_sql_varchar">,
        slug = <cfqueryparam value="#arguments.slugtopic#" cfsqltype="cf_sql_varchar">
        WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        
   </cfquery>

     <cfset result = "<div class='alert alert-success text-center mt-5' role='alert'>
          Haber Konusu Başarıyla Güncellendi.
      </div>">

   </cfif>

   <cfreturn result>


  </cffunction>


<cffunction name="DeleteNewsTopic" returntype="string" access="remote" >
      
   <cfargument name="id" type="integer" required="false">

   <cfset result = ''>

   <cfquery name="silmeSorgusu" datasource="#dbName#" username="#username#" password="#password#">
    
    DELETE FROM NewsContent
    WHERE NewsTopicID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">


   </cfquery>

   <cfquery datasource="#dbName#" username="#username#" password="#password#">

        DELETE FROM NewsTopic
        WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        
   </cfquery>

        <cfset result = "<div class='alert alert-success text-center mt-5' role='alert'>
          Haber Konusu Başarıyla Silindi.
      </div>">

   <cfreturn result>


</cffunction>



<cffunction name="AddNewsContent" returntype="string" access="remote" >

   <cfargument name="newstopicID" type="integer" required="false">   
   <cfargument name="header" type="string" required="false">
   <cfargument name="content" type="string" required="false">
   <cfargument name="slugcontent" type="string" required="false">
   <cfargument name="imgpathDB" type="string" required="true">

   <cfset NowTime = Now()>

   <cfquery datasource="#dbName#" username="#username#" password="#password#" name="IsHasSlug">

      SELECT * FROM NewsContent WHERE LOWER(slug) = LOWER(<cfqueryparam value='#arguments.slugcontent#' cfsqltype='cf_sql_varchar'>);

   </cfquery>


   <cfset result = "">

    <cfif IsHasSlug.recordCount neq 0>
   
      <cfset result = result & "<div class='alert alert-danger text-center mt-5' role='alert'>
        <i class='fa-solid fa-xmark text-danger'></i> Bu isme sahip bir slug zaten var.
      </div>" />

    <cfelse>

       <cfquery datasource="#dbName#" username="#username#" password="#password#">

        INSERT INTO NewsContent (Content,Header,NewsTopicID,slug,image,datetime)
        VALUES ('#arguments.content#','#arguments.header#',#arguments.newstopicID#,'#arguments.slugcontent#','#arguments.imgpathDB#',#NowTime#)

       </cfquery>

       <cfset result = "<div class='alert alert-success text-center mt-5' role='alert'>
          Haber Başarıyla eklendi.
      </div>">

     

    </cfif>
  

    <cfreturn result>


</cffunction>

<cffunction name="UpdateNewsContent" returntype="string" access="remote" >

   <cfargument name="id" type="integer" required="false">   
   <cfargument name="NewsTopicID" type="integer" required="false">   
   <cfargument name="Header" type="string" required="false">
   <cfargument name="Content" type="string" required="false">
   <cfargument name="slugcontent" type="string" required="false">
   <cfargument name="imgpathDB" type="string" required="true" default="">

    <cfquery datasource="#dbName#" username="#username#" password="#password#" name="IsHasSlug">

     SELECT * FROM NewsContent
     WHERE LOWER(slug) = LOWER(<cfqueryparam value='#arguments.slugcontent#' cfsqltype='cf_sql_varchar'>)
     AND id != <cfqueryparam value='#arguments.id#' cfsqltype='cf_sql_integer'>;

   </cfquery>

   <cfset result = "">

   <cfif IsHasSlug.recordCount neq 0>
   
       <cfset result = result & "<div class='alert alert-danger text-center mt-5' role='alert'>
        <i class='fa-solid fa-xmark text-danger'></i> Bu isme sahip bir slug zaten var.
      </div>" />

   <cfelse>

   <cfif imgpathDB neq "">
    
    <cfquery datasource="#dbName#" username="#username#" password="#password#">

     UPDATE NewsContent
     SET
     NewsTopicID = <cfqueryparam value="#arguments.NewsTopicID#" cfsqltype="cf_sql_integer">,
     Header = <cfqueryparam value="#arguments.Header#" cfsqltype="cf_sql_varchar">,
     Content = <cfqueryparam value="#arguments.Content#" cfsqltype="cf_sql_varchar">,
     slug = <cfqueryparam value="#arguments.slugcontent#" cfsqltype="cf_sql_varchar">,
     image = <cfqueryparam value="#arguments.imgpathDB#" cfsqltype="cf_sql_varchar">
     WHERE 
     id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">

    </cfquery>

         <cfset result = "<div class='alert alert-success text-center mt-5' role='alert'>
          Haber Başarıyla Güncellendi. (Tüm Alanlar İçin)
      </div>">

  <cfelse>
    
    <cfquery datasource="#dbName#" username="#username#" password="#password#">

     UPDATE NewsContent
     SET
     NewsTopicID = <cfqueryparam value="#arguments.NewsTopicID#" cfsqltype="cf_sql_integer">,
     Header = <cfqueryparam value="#arguments.Header#" cfsqltype="cf_sql_varchar">,
     Content = <cfqueryparam value="#arguments.Content#" cfsqltype="cf_sql_varchar">,
     slug = <cfqueryparam value="#arguments.slugcontent#" cfsqltype="cf_sql_varchar">
     WHERE 
     id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">

    </cfquery>

         <cfset result = "<div class='alert alert-success text-center mt-5' role='alert'>
          Haber Başarıyla Güncellendi (Resim Hariç)
      </div>">

  </cfif>  

  


  </cfif>
   
  <cfreturn result>


</cffunction>

<cffunction name="DeleteNewsContent" returntype="string" access="remote" >
      
   <cfargument name="id" type="integer" required="false">

   <cfset result="">

   <cfquery datasource="#dbName#" username="#username#" password="#password#">

        DELETE FROM NewsContent
        WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        
   </cfquery>

        <cfset result = "<div class='alert alert-success text-center mt-5' role='alert'>
          Haber Konusu Başarıyla Silindi.
      </div>">

   <cfreturn result>
  

</cffunction> 

    
</cfcomponent>
