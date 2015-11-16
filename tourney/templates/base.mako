<!DOCTYPE html>
<html>
  <head>
    <title>.:. Tourney .:.</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="/semantic/semantic.css" rel="stylesheet" type="text/css" />
    ${next.headIncludes()}
  </head>
  <body>
    <div class="ui main menu">
      <div class="menu_container">
        <a class="item" href="/">
          <i class="home icon"></i> Home
        </a>
      </div>
    </div>
    <div class="pusher">
      <div class="main container">
        <div id="subhead">
          ${next.headerIncludes()}
        </div>
        ${next.body()}
      </div>
    </div>
    <script type="text/javascript">
      // namespace
      window.semantic = {
        handler: {}
      };

      // Allow for console.log to not break IE
      if (typeof window.console == "undefined" || typeof window.console.log == "undefined") {
        window.console = {
          log  : function() {},
          info : function(){},
          warn : function(){}
        };
      }
      if(typeof window.console.group == 'undefined' || typeof window.console.groupEnd == 'undefined' || typeof window.console.groupCollapsed == 'undefined') {
        window.console.group = function(){};
        window.console.groupEnd = function(){};
        window.console.groupCollapsed = function(){};
      }
      if(typeof window.console.markTimeline == 'undefined') {
        window.console.markTimeline = function(){};
      }
      window.console.clear = function(){};

      semantic.ready = function() {
        $sortTable = $('.sortable.table');
        $dropdown = $('.dropdown');

        $dropdown.on('click', function(event) {
          $dropdown.dropdown('toggle');
          event.stopImmediatePropagation();
        });

        if($.fn.tablesort !== undefined && $sortTable.size() > 0) {
          $sortTable.tablesort();
        }
      }

      $(document).ready(semantic.ready);
    </script>

    ${next.javascriptIncludes()}
  </body>
</html>
