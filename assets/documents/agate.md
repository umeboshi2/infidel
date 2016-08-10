## Agate Application Structure

The structure is to run a multi page website as a collection 
of single page applications.  The webserver will provide an empty 
page, with only *font-awesome* and *bootstrap* css resources loaded 
in the head of the page.  The body is expected to be empty, or filled
with content expressing that the app is loading.

Backbone.Radio is being used to provide an "api"(I hope to flesh it out
more in the future) for communication between the child applets and the 
application, as well as between the children.  The main application has 
two channels, the main "global" channel and a "messages" channel.  Each 
applet should also provide it's own channel.  **An applet that depends 
on another applet's channel should be "required" after that other 
applet in the main app file.** 



### The Entry File

I keep the app for each page in an "entries" directory in the client source 
tree.  This lets me "require" a "base" or "startup" module that is common to 
each page, holding much of the boilerplate.  In the base entry file, the 
initial requirements are performed, such as importing the bootstrap 
javascript , as well as the modules that define handlers for the application 
and message radio channels.

After that an Appmodel should be defined, based on the BaseAppModel in agate.  
The appmodel contains basic structure of your application:

- **apiRoot:** this is new, but it will be the prefix to api calls

- **brand:**

	- name: the name of the brand at the top left corner
	- url: the link

- **container:** either "container" or "container-fluid"

- **layout_template:** if this is defined, it will be used
  instead of the default layout template.

- **frontdoor_app:**  This is the name of the applet 
  that will be used for the initial entry to the page.  **No** 
  backbone routing is setup in the main application space, and 
  responding to routing requests is the responsibility of the 
  applet.  Even though requiring the applets is still necessary in 
  the main application file, the application itself is just the 
  shell to run applets, and this requires an applet for initial 
  entry.
  
- **hasUser:** Are we running from a web server and expecting a login, or
  are we on a static site like github pages.  This being true, by default, 
  expects a "userprofile" app **(FIXME: which should be named in the 
  appmodel)** to be required and ready.
  
- **needUser:**  This isn't used yet, but can be used to force 
  a user to a login view.
  
- **frontdoor_sidebar:**  This isn't being used now, and may not 
  be supported anymore.
  
- **applets:**  This is a list (an array) of objects representing the applets
  being used with the application.  The "frontdoor" and "userprofile" 
  applets don't need to be listed here.  **Even though these are being 
  listed here, they need to be required separately and expressly in the 
  application file, due to how the webpack configuration works.**
  
  - Each applet should have a set of properties:
  
	  - **name:**  This is the label displayed on the navbar.
	  
	  - **url**  This is the url for the applet (#appname).
	  
	  - **appname:**  This is the name of the app and every route
	  it desribes should begin with "appname," e.g. "/#appname/viewstatus."
	  
  - An "applet" in the array that has no name will be treated as a 
  simple link, using the name and url properties.
  
- **regions:**  This is a list of regions for the region manager and should
  correspond to the layout template.  The named regions that are used most 
  are "content, sidebar, messages, and modal."

- **routes:**  This is not being used.






mainpage:init (uses initpage function)

navbar:displayed (display user menu if we have one)
