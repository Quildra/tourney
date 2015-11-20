<%inherit file="/admin/index.mako"/>

<%def name="event_template(event)">
	<div class="ui segment">
		<h2 class="ui header">
			<div class="content">
				${event.name}
		  </div>
		</h2>
		<div class="ui equal width grid">
			<div class="equal width row">
				<div class="column">
					Start Date: ${event.start_date.strftime('%d/%m/%Y')}
				</div>
				<div class="column">
					End Date: ${event.end_date.strftime('%d/%m/%Y')}
				</div>
			</div>
		</div>
		<div>
			Stats go here!
		</div>
		<div class="ui right aligned grid">
		<div class="right floated column">
			<button class="blue ui button">Manage Event</button>
			<button class="negative ui button" onclick="document.getElementById('modal_content').innerHTML = 'Are you sure you wish to delete the &quot;${event.name}&quot; event?'; $('.ui.basic.modal').modal({closable : false, onApprove : function() { $.post('/admin/events/delete', { uid: '${event.id}' }); }}).modal('show');" >
				Delete Event
			</button>
		</div>
		</div>
	</div>
</%def>

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
			${event_template(event)}
		% endfor
		<div class="ui horizontal divider">
			Future Events
		</div>
		% for event in future_events:
			${event_template(event)}
		% endfor
		<div class="ui horizontal divider">
			Past Events
		</div>
		% for event in past_events:
			${event_template(event)}
		% endfor
	</div>
	
	<div class="ui small basic modal">
		<div class="ui icon header">
			<i class="trash icon"></i>
			Delete Event
		</div>
		<div>
			<p id="modal_content"></p>
		</div>
		<div class="actions">
			<div class="ui green ok inverted button">
				<i class="checkmark icon"></i>
				Yes
			</div>
			<div class="ui basic cancel inverted button">
				<i class="remove icon"></i>
				No
			</div>
		</div>
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
