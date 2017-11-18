<%
	ui.decorateWith("appui", "standardEmrPage", [title: "Edit Request"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	jq(function () {
		jq('#agency').change(function(){
			var requestData = {
				id:		${disbursement.id},
				agency: jq(this).val()
			}
			
			jq.getJSON('${ ui.actionLink("mdrtbmanagement", "cashdisbursement", "getSubRecipientValues") }', requestData)
				.success(function (data) {
					var rows = data || [];
					var count = 1;
					var total = 0;
					jq('#locationList > tbody').empty();
					
					_.each(rows, function(data){
						var amounts = (data.amount?data.amount:0).toString().formatToAccounting();
						var comment = data.comment?data.comment:'';
						
						total += data.amount?data.amount:0;
						
						jq('#locationList > tbody').append("<tr><td>" + count + "</td><td>"+data.location.name.toUpperCase()+"</td><td>"+data.region.name.toUpperCase()+"</td><td class='textable'><input name='data."+data.id+"' value='"+amounts+"' /></td><td class='notable'><input name='note."+data.id+"' value='"+comment+"' /></td></tr>")
						count++;
					});
					
					//Add Summaries
					jq('#locationList > tbody').append("<tr><td>&nbsp;</td><td colspan='2'><b>TOTALS</b></td><td style='padding:0'><input id='totals' style='font-weight:bold;' name='disbursement.amount' readonly='' value='"+ total.toString().formatToAccounting() +"' /></td><td><b>N/A</b></td></tr>");
					jq('#locationList > tbody').append("<tr><td>&nbsp;</td><td colspan='2'>ADJUSTMENT ESTIMATE</td><td style='padding:0'><input id='estimate' name='disbursement.estimate' value='"+${disbursement.estimate}.toString().formatToAccounting()+"' /></td><td class='notable'><input name='note.' /></td></tr>");
				}).error(function (xhr, status, err) {
					jq('#locationList > tbody').append("<tr><td>&nbsp;</td><td colspan='4'>NO DATA FOUND</td></tr>");
					jq().toastmessage('showErrorToast', 'Error Loading Details. ' + err);
				}
			);
		}).change();
		
		jq('#locationList').on('change', '.textable input', function() {
			var val = jq(this).val();
			var sum = 0;
			
			jq(this).val(val.toString().formatToAccounting()!='NaN'?val.toString().formatToAccounting():'');
			
			jq(".textable input").each(function(){
				val = jq(this).val().replace(',','').replace(' ','');
				if (!isNaN(parseFloat(val)) && isFinite(val) && val > 0) {
					sum += +val;
				}
			});
			
			jq("#totals").val(sum.toString().formatToAccounting());
		});
		
		jq('#locationList').on('focus', '.textable input, #estimate', function() {
			var val = jq(this).val().replace(',','').replace(' ','');;
			if (isNaN(parseFloat(val)) || isFinite(val) && val == 0) {
				jq(this).val('');
			}
		});
		
		jq('#locationList').on('change', '#estimate', function() {
			jq(this).val(jq(this).val().toString().formatToAccounting()!='NaN'?jq(this).val().toString().formatToAccounting():'');
		});
		
		 jq('#cancelButton').click(function(){
			window.location.href = "cashdisbursement.page";
		});
		
		jq('#addRequest').click(function(){
			if (parseFloat(jq('#totals').val()) <= 0){
				jq().toastmessage('showErrorToast', 'Invalid Total Amount for the specified Request');
				return false;
			}
			
			jq('.dialog-content .confirmation').html("Confirm posting new Cash Request for <b>" + jq('#agency option:selected').text() + " Agency</b> worth <b>&dollar;" + jq('#totals').val()+"</b> ?");
			confirmDialog.show();
		});
		
		var confirmDialog = emr.setupConfirmationDialog({
			dialogOpts: {
				overlayClose: false,
				close: true
			},
			selector: '#confirm-dialog',
			actions: {
				confirm: function () {
					var dataString = jq('form').serialize();
					
					jq.ajax({
						type: "POST",
						url: '${ui.actionLink("mdrtbmanagement", "cashdisbursement", "updateFundsRequest")}',
						data: dataString,
						dataType: "json",
						success: function (data) {
							if (data.status == "success") {
								jq().toastmessage('showSuccessToast', data.message);
								window.location.href = "cashdisbursement.page";
							}
							else {
								jq().toastmessage('showErrorToast', 'Post failed. ' + data.message);
							}
						},
						error: function (data) {
							jq().toastmessage('showErrorToast', "Post failed. " + data.statusText);
						}
					});
					confirmDialog.close();
				},
				cancel: function () {
					confirmDialog.close();
				}
			}
		});
		
		jq("#qtr").val(${qtrs});
	});
</script>

<style>
	#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
		text-decoration: none;
	}
	.name {
		color: #f26522;
	}

	.budget-box{
		border: 1px solid #d3d3d3;
		border-top: 2px solid #363463;
		height: auto;
		margin: 15px 0 0 0;
		padding-bottom: 5px;
	}
	.budget-box div{
		width: 36%;
		display: inline-block;
	}
	.budget-box label{
		display: inherit;
		padding: 2px 10px;
		margin: 10px 0 0 0;
		width: 60px;

	}
	input, form input, select, form select, ul.select, form ul.select, textarea {
		min-width: 0;
		display: inline-block;
		width: 230px;
		height: 38px;
	}
	input, select, textarea, form ul.select, .form input, .form select, .form textarea, .form ul.select {
		color: #363463;
		padding: 5px 10px;
		background-color: #FFF;
		border: 1px solid #DDD;
	}
	textarea{
		resize: none;
		height: 120px;
		margin-top: 2px;
		width: 400px;
	}
	#date-created label{
		display: inline-block;
	}
	#budgetTable {
		border-top: 2px solid #363463;
		margin-top: 2px;
		font-size: 14px;
	}
	#budgetTable tr th{
		text-align: center;
	}
	#budgetTable tr td:nth-child(2),
	#budgetTable tr td:nth-child(3),
	#budgetTable tr td:nth-child(4),
	#budgetTable tr td:nth-child(5){
		text-align: right;
	}
	.notable,
	.textable{
		padding:0;
	}
	#estimate,
	#totals,
	.textable input {
		background-color: transparent;
		margin: 0px;
		border: none;
		width: 100px;
		height: auto;
		text-align: right;
	}
	.notable input {
		background-color: transparent;
		margin: 0px;
		border: none;
		height: auto;
		width: 100%;
	}
	#totals {
		font-weight: bold;
	}
	input.child{
		padding-right: 20px;
	}
	.button.confirm{
		margin-right:0px;
	}
	.dialog-content .confirmation{
		margin-bottom: 20px;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.3 !important;
	}
	#locationList{
		font-size: 14px;
		margin-top: 5px;
	}
</style>

<div class="example">
    <ul id="breadcrumbs">
        <li>
            <a href="${ui.pageLink('referenceapplication', 'home')}">
                <i class="icon-home small"></i></a>
        </li>

        <li>
            <i class="icon-chevron-right link"></i>
            <a href="financedashboard.page?view=srs">Finance</a>
        </li>

        <li>
            <i class="icon-chevron-right link"></i>
            <a href="cashdisbursement.page">Disbursements</a>
        </li>

        <li>
            <i class="icon-chevron-right link"></i>
            Edit Request
        </li>
    </ul>
</div>

<form class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-bookmark-empty small"></i>EDIT REQUEST &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div id="show-icon">
		&nbsp;
	</div>

	<div class="budget-box">
		<div>
			${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'disbursement.date', id: 'date-created', label: 'Date:', useTime: false, defaultDate: disbursement.date])}
		</div>

		<div style="width: 63%; float: right">
			<label style="display: inline-block">Notes</label>
			<textarea name="disbursement.description" style="min-width: 0;display: inline-block;margin-top: 5px;">${disbursement.description}</textarea>
			<input type="hidden" name="disbursement.id" value="${disbursement.id}" />
		</div>

		<div>
			<label>Quarter</label>
			<select name="disbursement.quarter" id="qtr" style="width:70px">
				<option value="1">01</option>
				<option value="2">02</option>
				<option value="3">03</option>
				<option value="4">04</option>
			</select>

			<select name="disbursement.year" id="yrs" style="width:157px">
                <% years.eachWithIndex { yr, index -> %>
                <option value="${yr}" ${yr==year?'selected':''}  '>${yr}</option>
                <% } %>
			</select>
		</div>

		<div>
			<label>SRs</label>
			<select id="agency" name="disbursement.agency">
                <% agencies.eachWithIndex { loc, index -> %>
                <option value="${loc.id}" ${loc==disbursement.agency?'selected':''} '>${loc.name}</option>
                <% } %>
			</select>
		</div>
		
		<span class="clear both"></span>
	</div>
	
	<table id="locationList">
		<thead>
			<th style="width:1px">#</th>
			<th style="width:250px;">FACILITY</th>
			<th style="width:150px;">LOCATION</th>
			<th style="width:80px">AMOUNT</th>
			<th>NARRATION</th>
		</thead>

		<tbody>
			<tr>
				<td>1</td>
			</tr>
		</tbody>
	</table>

	<div style="margin: 5px 0 10px;">
		<span class="button confirm right" id="addRequest">
			<i class="icon-save small"></i>
			Save
		</span>

		<span class="button cancel" id="cancelButton">
			<i class="icon-remove small"></i>
			Cancel
		</span>
	</div>

</form>

<div id="confirm-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>CONFIRM POSTING</h3>
    </div>

    <div class="dialog-content">
        <div class="confirmation">
            Confirm
        </div>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>