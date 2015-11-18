<%inherit file="/admin/index.mako"/>

<%def name="body()">
<div>
	Events, YAY!
</div>
	<div class="ui container">
	<a class="ui fluid button" onclick="$('#createnew_body').slideToggle('slow');">
		Create New
	</a>
	<div class="ui segment" id="createnew_body" style="display: none;">
		<div id="create_form" class="ui large form">
			<form method="post" action="createnewreradingorder" id="createnew">
				<div class="two fields">
					<div class="field">
						<label>Event Name</label>
						<input type="Text" name="name">
					</div>
					<div class="field">
					  <label>UID</label>
					  <input type="Text" name="uid", placeholder="Leave blank unless you are cloning an event">
					</div>
				</div>

				<a class="ui labeled icon positive button" style="margin-top:1em;" onclick="CreateNew()">
				  <i class="checkmark icon"></i>
				  Create
				</a>
			</form>
		</div>
	</div>
	
	</div>
</%def>