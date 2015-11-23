<%inherit file="/admin/index.mako"/>

<%block name="head">
	<link rel="stylesheet" type="text/css" href="/css/daterangepicker.css" />
</%block>

<%block name="body">
	<h2 class="ui center aligned icon header">
		<i class="circular calendar icon"></i>
		Manage Event
	</h2>
	<div class="ui horizontal divider">
		Event Details
	</div>
	<div class="ui segment container">
		<form method="post" action="/admin/events/update" class="ui form">
			<div class="two fields">
				<div class="field">
					<label>Event Name</label>
					<input type="Text" name="event_name" value="${selected_event.name}">
				</div>
				<div class="field">
				  <label>UID</label>
				  <input type="Text" name="uid", value="${selected_event.id}">
				</div>
			</div>
			
			<div class="two fields">
				<div class="field">
					<label>Start Date</label>
					<input type="text" name="start_date" value="${selected_event.start_date.strftime('%d/%m/%Y')}"/>
				</div>
				<div class="field">
					<label>End Date</label>
					<input type="text" name="end_date" value="${selected_event.start_date.strftime('%d/%m/%Y')}"/>
				</div>
			</div>

			<button type="submit" class="ui labeled icon positive button">
				<i class="checkmark icon"></i>
				Apply
			</button>
		</form>
	</div>
	<div class="ui horizontal divider">
		Tournaments
	</div>
</%block>

<%block name="javascript_includes">
	<script type="text/javascript" src="/js/moment-with-locales.js"></script>
	<script type="text/javascript" src="/js/daterangepicker.js"></script>
	<script type="text/javascript">
		$(document).ready(function() 
			{
				daterangepicker_now = moment();
				moment.locale("en-GB");
				current_date = moment().format('L');
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
