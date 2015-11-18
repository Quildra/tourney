<%inherit file="/base.mako"/>

<%def name="headIncludes()">
  <style>

  </style>
</%def>

<%def name="headerIncludes()">
</%def>

<%def name="body()">
	<div class="ui vertical inverted sticky menu fixed top" style="left: 0px; top: 0px; width: 250px !important; height: 1813px !important; margin-top: 0px;">
		<a class="item" href="/admin/events">
		  <b>Events</b>
		</a>
		<a class="item" href="/admin/users">
		  <b>Users</b>
		</a>
		<a class="item" href="/admin/players">
		  <b>Players</b>
		</a>
		<a class="item" href="/admin/plugins">
		  <b>Plugins</b>
		</a>
	</div>
	${next.body()}
</%def>

<%def name="javascriptIncludes()">
</%def>
