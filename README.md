<h1>News Project ColdFusion</h1>

<p>This project is designed to include the functions of a news website. The project includes all CRUD functions.
   It has the functions of adding news, reading news, updating and deleting news. At the same time, adding, updating and deleting news topics
   can be done.</p>

<h2>Technologies used in the project</h2>
<ul>
  <li>✔️ ColdFusion</li>
  <li>✔️ HTML</li>
  <li>✔️ CSS</li>
  <li>✔️ Bootstrap</li>
  <li>✔️ JavaScript</li>
  <li>✔️ MSSQL</li>
</ul>

<h2>Start and Run</h2>
<ol>
  <li>Import the DbNewsProject.bak backup into mssql.</li>
  <br/>
  <li>Install ColdFusion</li>
  <br/>
  <li>After installing coldfusion, perform the configuration operations. Select the wwwroot directory in the directory where coldfusion is installed.</li>
  <br/>
  <li>Upload NewsProject folder to wwwroot directory.</li> 
  <br/>
  <li>Start coldfusion server service.</li>
</ol>

<p>Now that we have started our project, we can access our project from the relevant address. By default, the port is set to 8500, you can change it from the settings if you wish.</p>
<h3>Local Address</h3>

```
http://localhost:8500/NewsProject

```
<h2>Project Features</h2>
<ul>
<li>The news content you added in the last 3 days is displayed in the slider on the home page and is deleted after 3 days.</li>
<br/>
<li>There are news topics we added in the menu next to the logo. When we click on one of these topics, the news we added under the relevant topic is listed.</li>
<br/>
<li>previous image for repository management while updating It is deleted from the server so that unnecessary storage space is not taken up.</li>
<br/>
<li>For error management, I prevented some errors made by users. For example, to avoid url conflicts, if there was content with the relevant slug, I prevented the user from creating content with this slug.</li>
</ul>

<br/>

<div align="center">
<h2>Images</h2>
</div>
