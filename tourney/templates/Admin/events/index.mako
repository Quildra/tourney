<%inherit file="/admin/index.mako"/>

<%block name="head">
	<link rel="stylesheet" type="text/css" href="/css/daterangepicker.css" />
</%block>

<%block name="body">
	<h2 class="ui center aligned icon header">
		<i class="circular calendar icon"></i>
		Events
	</h2>
	<div class="ui container">
		<a class="ui fluid button" onclick="$('#createnew_body').slideToggle('slow');">
			New Event
		</a>
		<div class="ui segment" id="createnew_body" style="display: none;">
			<div id="create_form">
				<form method="post" action="/admin/events/create" id="event_create_new" class="ui form">
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
		<div class="ui horizontal divider">
			Active Events
		</div>
		% for event in active_events:
			<div>
				${event.name}
			</div>
		% endfor
		<div class="ui horizontal divider">
			Future Events
		</div>
		% for event in future_events:
			<div>
				${event.name}
			</div>
		% endfor
		<div class="ui horizontal divider">
			Past Events
		</div>
		% for event in past_events:
			<div>
				${event.name}
			</div>
		% endfor
	</div>
</%block>

<%block name="javascript_includes">
	<script type="text/javascript" src="/js/moment-with-locales.js"></script>
	<script type="text/javascript" src="/js/daterangepicker.js"></script>
	<script type="text/javascript">
		$(document).ready(function() 
			{
				daterangepicker_now = moment()
				moment.locale("en-GB");
				current_date = moment().format('L');
				document.getElementsByName("start_date")[0].value = current_date;
				$('input[name="start_date"]').daterangepicker(
					{
						format: 'DD/MM/YYYY',
						singleDatePicker: true,
						startDate: daterangepicker_now
					}
				);
				$('input[name="end_date"]').daterangepicker(
					{
						format: 'DD/MM/YYYY',
						singleDatePicker: true,
						startDate: daterangepicker_now
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
