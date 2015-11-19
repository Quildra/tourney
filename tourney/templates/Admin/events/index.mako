<%inherit file="/admin/index.mako"/>

<%block name="head">
	<link rel="stylesheet" type="text/css" href="/css/daterangepicker.css" />
</%block>

<%block name="body">
<div>
	Events, YAY!
</div>
	<div class="ui container">
		<a class="ui fluid button" onclick="$('#createnew_body').slideToggle('slow');">
			Create New
		</a>
		<div class="ui segment" id="createnew_body" style="display: none;">
			<div id="create_form">
				<form method="post" action="/admin/event/create" id="event_create_new" class="ui form">
					<div class="two fields">
						<div class="required field">
							<label>Event Name</label>
							<input type="Text" name="event_name" placeholder="Name of the event">
						</div>
						<div class="field">
						  <label>UID</label>
						  <input type="Text" name="uid", placeholder="Leave blank unless you are cloning an event">
						</div>
					</div>
					
					<div class="two fields">
						<div class="required field">
							<label>Start Date</label>
							<input type="text" name="start_date" />
						</div>
						<div class="field">
							<label>End Date</label>
							<input type="text" name="end_date" />
						</div>
					</div>

					<button type="submit" class="ui labeled icon positive button">
						<i class="checkmark icon"></i>
						Create
					</button>
				</form>
			</div>
		</div>

	</div>
</%block>

<%block name="javascript_includes">
	<script type="text/javascript" src="/js/moment.js"></script>
	<script type="text/javascript" src="/js/daterangepicker.js"></script>
	<script type="text/javascript">
		$(document).ready(function() 
			{
				moment.locale("en-GB");
				current_date = moment().format('L');
				document.getElementsByName("start_date")[0].value = current_date;
				$('input[name="start_date"]').daterangepicker(
					{
						singleDatePicker: true
					}
				);
				$('input[name="end_date"]').daterangepicker(
					{
						singleDatePicker: true
					}
				);
				$('.ui.form').form(
				{
					fields: {
					  text: {
						identifier  : 'event_name',
						rules: [
						  {
							type   : 'empty',
							prompt : 'Please enter a value'
						  }
						]
					  }
					}
				}
				);
			}
		);
</script>
</%block>
