<!DOCTYPE html>

<%!
import tourney
import cherrypy
from lib.modules.simple_auth import get_user
%>

<html>
    <head>
      <title>.:. Tourney .:.</title>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <link href="/semantic/semantic.css" rel="stylesheet" type="text/css" />
      <%block name="head"/>
    </head>
    <body>
      <div class="ui left vertical menu sidebar">
        <%
          user = get_user()
        %>
        % if user is None:
        <a class="ui item" href="/auth/login">
          <i class="sign in icon"></i>
          Sign In
        </a>
        %endif
        % if user is not None:
        <div class="ui card">
          <div class="image">
            <img src="" alt="" />
          </div>
          <div class="content">
            <a class="header">${user.username}</a>
            <div class="meta">
              <span class="date">user.join_date</span>
            </div>
            <div class="meta">
              <span class="">Role</span>
            </div>
          </div>
        </div>
        % endif
        <a class="ui item" href="/">
          <i class="home icon"></i>
          Home
        </a>
        <%block name="menu_items"/>
        % if user is not None:
        <a class="ui item" href="/auth/logout">
          <i class="sign out icon"></i>
          Sign Out
        </a>
        %endif
      </div>
      <div class="pusher">
        <div class="full height">
          <div class="following bar">
            <div class="ui container">
              <div class="ui large secondary network menu">
                <a class="view-ui item sidebar toggle button" data-transition="overlay">
                  <i class="sidebar icon"></i>
                  Menu
                </a>
              </div>
            </div>
          </div>
          <div class="ui stackable very relaxed center aligned grid container">
            ${self.body()}
          </div>
        </div>
      </div>

      <script src="/js/jquery-2.1.4.min.js"></script>
      <script src="/semantic/semantic.js" type="text/javascript"></script>
      <script type="text/javascript">
        window.semantic = { handler: {} };
        $('.ui.sidebar').sidebar('setting', 'transition', 'overlay').sidebar('attach events', '.sidebar.toggle.button')
        $(document).ready(semantic.ready);
      </script>

      <%block name="javascript_includes"/>
    </body>
</html>
