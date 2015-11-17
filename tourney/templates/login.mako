<!DOCTYPE HTML>
<html>
  <head>
    <title>.:. Tourney .:.</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="/semantic/semantic.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
      body {
        background-color: #DADADA;
      }
      body > .grid {
        height: 100%;
      }
      .image {
        margin-top: -100px;
      }
      .column {
        max-width: 450px;
      }
    </style>

  </head>
  <body>
    <div class="ui middle aligned center aligned grid">
      <div class="column">
        <h2 class="ui teal image header">
          <img src="" class="image" />
          <div class="content">
            Log-in to your account
          </div>
        </h2>
        <form class="ui large form" method="post" action="/auth/login">
          <div class="ui stack segment">
            <input type="hidden" name="from_page" value=${from_page} />
            <div class="field">
              <div class="ui left icon input">
                <i class="user icon"></i>
                <input type="text" name="username" placeholder="Username" value="${username}" />
              </div>
            </div>
            <div class="field">
              <div class="ui left icon input">
                <i class="lock icon"></i>
                <input type="password" placeholder="Password" name="password" />
              </div>
            </div>
            <button type="submit" class="ui button">Login</button>
          </div>
          % if msg is not "":
          <div class="ui visible error message">
          % else:
          <div class="ui error message">
          % endif
            <i class="close icon"></i>
            <div class="header">
              Error
            </div>
            <ul class="list">
              <li>${msg}</li>
            </ul>
          </div>
        </form>
      </div>
    </div>
    <script src="/js/jquery-2.1.4.min.js"></script>
    <script src="/semantic/semantic.js" type="text/javascript"></script>
    <script type="text/javascript">
      window.semantic = { handler: {} };
      $('.ui.sidebar').sidebar('setting', 'transition', 'overlay').sidebar('attach events', '.sidebar.toggle.button')
      $('.message .close').on('click', function()
        {
          $(this).closest('.message').transition('fade');
        }
      );
      $(document).ready(semantic.ready);
    </script>
  </body>
</html>
