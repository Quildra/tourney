<%inherit file="/admin/index.mako"/>

<%!
import tourney
%>

<%block name="head">
	<link rel="stylesheet" type="text/css" href="/css/daterangepicker.css" />
	<link rel="stylesheet" type="text/css" href="/css/datetimepicker.css" />
</%block>

<%def name="tournament_template(tournament)">
	<div class="ui segment">
		<h2 class="ui header">
			<div class="content">
				${tournament.title}
		  </div>
		</h2>
		<div class="ui equal width grid">
			<div class="equal width row">
				<div class="column">
					Game: ${tourney.PLUGIN_MANAGER.get_plugin(tournament.game_system_id).game_system}
				</div>
				<div class="column">
					Pairing System: ${tournament.pairing_system_id}
				</div>
			</div>
			<div class="equal width row">
				<div class="column">
					Regestration Starts: ${tournament.reg_start_time.strftime('%H:%M')}
				</div>
				<div class="column">
					Regestration Ends: ${tournament.reg_end_time.strftime('%H:%M')}
				</div>
				<div class="column">
					Round One Starts: ${tournament.round_one_start_time.strftime('%H:%M')}
				</div>
			</div>
		</div>
		<div>
			
		</div>
		<div class="ui right aligned grid">
		<div class="right floated column">
			<button class="blue ui button" onclick="location.href='/admin/events/manage?event_id='">Manage Event</button>
			<button class="negative ui button" onclick="document.getElementById('modal_content').innerHTML = 'Are you sure you wish to delete the &quot;&quot; event?'; $('.ui.basic.modal').modal({closable : false, onApprove : function() { $.post('/admin/events/delete', { uid: '' }); location.reload(true);}}).modal('show');" >
				Delete Event
			</button>
		</div>
		</div>
	</div>
</%def>

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
	<div class="ui container">
		<a class="ui fluid button" onclick="$('#add_tournament_body').slideToggle('slow');">
			Add Tournament
		</a>
		<div class="ui segment" id="add_tournament_body" style="display: none;">
			<form method="post" action="/admin/tournaments/create" class="ui form">
				<input type="hidden" name="event_id" value="${selected_event.id}">
				<input type="hidden" name="team_event" value="False">
				<div class="required field">
					<label>Game System</label>
					<div class="ui dropdown selection" id="game_system_dropdown">
						<input type="hidden" name="game_system">
						<div class="default text">Select a game system</div>
						<i class="dropdown icon"></i>
						<div class="menu">
							% for k,v in game_systems.items():
								<div class="item" data-value="${k}">${v.game_system}</div>
							% endfor
						</div>
					</div>
				</div>
				<div class="required field">
					<label>Pairing System</label>
					<div class="ui dropdown selection" id="pairing_system_dropdown">
						<input type="hidden" name="pairing_system">
						<div class="default text">Select a pairing system</div>
						<i class="dropdown icon"></i>
						<div class="menu">
							<div class="item" data-value="round_robin">Round Robin</div>
							<div class="item" data-value="swiss">Swiss</div>
							<div class="item" data-value="single_elimination">Single Elimination</div>
							<div class="item" data-value="double_elimination">Double Elimination</div>
						</div>
					</div>
				</div>
				<div class="field">
					<label>Title</label>
					<input type="Text" name="title" value="">
				</div>
				<div class="three fields">
					<div class="field">
						<label>Registration Begins</label>
						<input class="ui dropdown datetimepicker" type="text" name="reg_start_time"/>
					</div>
					<div class="field">
						<label>Registration Ends</label>
						<input class="ui dropdown datetimepicker" type="text" name="reg_end_time"/>
					</div>
					<div class="required field">
						<label>Round One Starts</label>
						<input class="ui dropdown datetimepicker" type="text" name="round_one_start" />
					</div>
				</div>
				
				<div class="three fields">
					<div class="field">
						<label>Player Limit</label>
						<input type="number" name="player_limit" />
					</div>
					<div class="inline field">
						<div class="ui toggle checkbox">
							<input type="checkbox" tabindex="0" class="hidden" name="team_event_checkbox">
							<label>Team Event</label>
						</div>
					</div>
					<div class="disabled field" id="players_per_team_div">
						<label>Players Per Team</label>
						<input type="number" id="players_per_team" name="players_per_team" disabled/>
					</div>
				</div>
				<div class="field">
					<label>Description</label>
					<textarea name="description"></textarea>
				</div>

				<button type="submit" class="ui labeled icon positive button">
					<i class="checkmark icon"></i>
					Create
				</button>
			</form>
		</div>
		<div class="ui horizontal divider">
			Existing Tournaments
		</div>
		% for tournament in selected_event.tournaments:
			${tournament_template(tournament)}
		% endfor
	</div>
</%block>

<%block name="javascript_includes">
	<script type="text/javascript" src="/js/moment-with-locales.js"></script>
	<script type="text/javascript" src="/js/daterangepicker.js"></script>
	<script type="text/javascript" src="/js/datetimepicker.js"></script>
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
				$('#pairing_system_dropdown').dropdown();
				$('#game_system_dropdown').dropdown({
					onChange: function(value, text, $selectedItem) {
						$('input[name="title"]').val(text);
					}
				});
				$('.ui.checkbox').checkbox().first().checkbox({
					onChecked: function() {
						$('#players_per_team_div').removeClass("disabled");
						$('#players_per_team').prop('disabled', false);
						$('input[name="team_event"]').val("True");
					},
					onUnchecked: function() {
						$('#players_per_team_div').addClass("disabled");
						$('#players_per_team').prop('disabled', true);
						$('input[name="team_event"]').val("False");
					}
				});
				$('.datetimepicker').datetimepicker({
					format:'HH:mm'
                });
			}
		);
	</script>
</%block>
