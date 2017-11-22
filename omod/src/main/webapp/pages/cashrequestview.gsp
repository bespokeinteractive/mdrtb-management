<%
	ui.decorateWith("appui", "standardEmrPage", [title: "View Request"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	jq(function () {
		jq('.confirm-receipt').click(function(){
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
                    var dataString = {
						id: 	${disbursement.id},
						date:	jq('#disDate-field').val(),
						note:	jq('#disConfirm').val()
					}

                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "cashdisbursement", "confirmDisbursement")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "cashdisbursement.page?tab=approved";
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
		margin: 5px 0 0 0;
		padding-bottom: 5px;
	}
	.budget-box div{
		width: 36%;
		display: inline-block;
	}
	.budget-box label{
		display: inherit;
		padding: 2px 10px;
		margin: 5px 0 0 0;
		width: 80px;
		font-size: 0.95em;
		color: #555;

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
	.show-icon {
		float: right;
		font-family: "OpenSansBold";
		font-size: 1.5em;
		margin: 0 0 -5px 0;
	}
	.budget-box a {
		color: #007fff!important;
		text-decoration: none;
		cursor: pointer;
	}
	.dialog .dialog-content li {
		margin-bottom: 0;
	}
	.dialog-content ul li label{
		display: inline-block;
		width: 120px;
	}
	.dialog-content ul li input[type=text],
	.dialog-content ul li select,
	.dialog-content ul li textarea {
		border: 1px solid #ddd;
		display: inline-block;
		height: 40px;
		margin: 1px 0;
		min-width: 20%;
		padding: 5px 0 5px 10px;
		width: 58%;
	}
	.dialog-content ul li textarea{
		height: 100px;
		resize: none;
	}
	.dialog select option {
		font-size: 1em;
	}
	.dialog ul {
		margin-bottom: 20px;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.3 !important;
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
            Request
        </li>
    </ul>
</div>

<div class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-bookmark-empty small"></i>VIEW REQUEST &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div class="show-icon">
		<i class="icon-globe small"></i>${disbursement.agency.name}&nbsp;
	</div>
	<div class="clear both"></div>

	<div class="budget-box">
		<div>
			<label>Date :</label>${ui.formatDatePretty(disbursement.date) }<br/>
			<label>Period :</label>${disbursement.period}<br/>
		</div>
		
		<div style="width: 63%; float: right">
			<label style="display: inline-block; height: 30px;">Notes :</label>${disbursement.description==''?'N/A':disbursement.description}			
			<div style="width:100%; bottom:0; float:right; text-align:right; margin:0 15px -10px 0; font-size:0.9em;">
				<% if (confirm ==1 && edit == 1) { %>
					<a class="confirm-receipt">Confirm</a> | <a href="cashrequestedit.page?id=${disbursement.id}">Edit</a>
				<% } else if (confirm == 1) { %>
					<a class="confirm-receipt"><i class="icon-ok small"></i>Confirm</a>
				<% } else if (edit == 1) { %>
					<a href="cashrequestedit.page?id=${disbursement.id}"><i class="icon-pencil small"></i> Edit</a>
				<% } %>
			</div>
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
			<% details.eachWithIndex { dtl, index -> %>
				<tr>
					<td>${index+1}</td>
					<td>${dtl.centre.location.name.toUpperCase()}</td>
					<td>${dtl.centre.region.name.toUpperCase()}</td>
					
					<% if (disbursement.approvedOn) { %>
						<td style="text-align:right;">${String.format("%1\$,.2f", dtl.approved)}</td>		
					<% } else { %>
						<td style="text-align:right;">${String.format("%1\$,.2f", dtl.amount)}</td>		
					<% } %>
					
					
					<td>${dtl.narration==''?'N/A':dtl.narration.toUpperCase()}</td>
				</tr>
			<% } %>
			
			<tr>
				<td>&nbsp;</td>
				<td colspan='2'><b>TOTALS</b></td>
				
				<% if (disbursement.approvedOn) { %>
					<td style="text-align:right;"><b>${String.format("%1\$,.2f", disbursement.approved)}</b></td>
				<% } else { %>	
					<td style="text-align:right;"><b>${String.format("%1\$,.2f", disbursement.amount)}</b></td>
				<% } %>
				
				<td><b>N/A</b></td>
			</tr>
			
			<tr>
				<td>&nbsp;</td>
				<td colspan='2'>ADJUSTMENT ESTIMATE</td>
				<td style="text-align:right;">${String.format("%1\$,.2f", disbursement.estimate)}</td>
				<td>&nbsp;</td>
			</tr>
		</tbody>
	</table>
	
	<div style="margin: 5px 0 10px;">
		<span class="button task right" id="addBudget">
			<i class="icon-print small"></i>
			Print
		</span>
	</div>
</div>

<div id="confirm-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>CONFIRM RECEIPT</h3>
    </div>

    <div class="dialog-content">
		<ul>
			<li>
				<label for="addNames">AGENCY:</label>
				<input type="text" id="disName" readonly="" value="${disbursement.agency.name}"/>
			</li>

			<li>
				<label for="editNames">AMOUNT:</label>
				<input type="text" id="disAmount" readonly="" value="${String.format("%1\$,.2f", disbursement.amount)}"/>
			</li>

			<li>
				<label for="editNames">ADJUSTMENT:</label>
				<input type="text" id="disAdjust" readonly="" value="${String.format("%1\$,.2f", disbursement.estimate)}"/>
			</li>

			<li>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'confirm.date', id: 'disDate', label: 'DATE:', useTime: false, defaultToday: true])}
			</li>
			
			<li>
				<label for="editNames">CONFIRM:</label>
				<textarea id="disConfirm" placeholder="Narration"></textarea>
			</li>
		</ul>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>