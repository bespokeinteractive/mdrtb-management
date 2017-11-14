<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "Add Budget"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	jq(function () {
		jq('.textable').on("change", "input", function() {
			var val = jq(this).val();
			var sum = 0;
			var tot = 0;
			var parent = "";
			
			jq(this).val(val.toString().formatToAccounting()!='NaN'?val.toString().formatToAccounting():'');
			
			jq(".textable input").each(function(){
				val = jq(this).val();
				
				if (!isNaN(parseFloat(val)) && isFinite(val) && val > 0) {
					sum += +val;
				}
				else {
					val = 0;
				}
				
				//Groups
				if (jq(this).hasClass('child')){
					if (parent == ''){
						parent = jq(this).data('uuid');
						tot = +val;
					}
					else if(parent == jq(this).data('uuid')){
						tot += +val;
					}
					else {
						jq(".parent_"+parent).text(tot.toString().formatToAccounting());
						
						tot = +val;
						parent = jq(this).data('uuid');
					}
				}
				else {
					jq(".parent_"+parent).text(tot.toString().formatToAccounting());
					
					tot = 0;
					parent = '';
				}
			});
			
			jq(".parent_"+parent).text(tot.toString().formatToAccounting());
			jq("#totals").val(sum.toString().formatToAccounting());
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
                        url: '${ui.actionLink("mdrtbmanagement", "financebudget", "addNewBudget")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "financebudget.page";
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
		
		jq('#cancelButton').click(function(){
			window.location.href = "budgetadd.page?reset=true";
		});
		
		jq('#addBudget').click(function(){
			if (parseFloat(jq('#totals').val()) <= 0){
				jq().toastmessage('showErrorToast', 'Invalid Total Amount for the specified Budget');
				return false;
			}
			
			jq('.dialog-content .confirmation').html("Confirm posting new Budget for <b>" + jq('#facility option:selected').text() + " Facility</b> worth <b>&dollar;" + jq('#totals').val()+"</b> ?");
			
			confirmDialog.show();
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
	.textable{
		padding:0;
	}
	#totals,
	.textable input {
		background-color: transparent;
		margin: 0px;
		border: none;
		width: 100px;
		height: auto;
		text-align: right;
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
</style>

<div class="container">
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
                <a href="financebudget.page">Budget</a>
            </li>

            <li>
                <i class="icon-chevron-right link"></i>
                Add Budget
            </li>
        </ul>
    </div>

    <form class="patient-header new-patient-header">
        <div class="demographics">
            <h1 class="name" style="border-bottom: 1px solid #ddd;">
                <span><i class="icon-paste small"></i>ADD BUDGET &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
            </h1>
        </div>

        <div id="show-icon">
            &nbsp;
        </div>
		
		<div class="budget-box">
			<div>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'budget.date', id: 'date-created', label: 'Date:', useTime: false, defaultToday: true])}
			</div>
			
			<div style="width: 63%; float: right">
				<label style="display: inline-block">Notes</label>
				<textarea name="budget.description" style="min-width: 0;display: inline-block;margin-top: 5px;"></textarea>
			</div>
			
			
			<div>
				<label>Quarter</label>
				<select name="budget.quarter" id="qtr" style="width:70px">
					<option value="1">01</option>
					<option value="2">02</option>
					<option value="3">03</option>
					<option value="4">04</option>
				</select>
				
				<select name="budget.year" id="yrs" style="width:157px">
					<% years.eachWithIndex { yr, index -> %>
						<option value="${yr}" ${yr==year?'selected':''}  '>${yr}</option>
					<% } %>
				</select>
			</div>
			
			<div>
				<label>Facility</label>
				<select id="facility" name="budget.facility">
					<% locations.eachWithIndex { loc, index -> %>
						<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
					<% } %>
				</select>
			</div>
			
			<span class="clear both"></span>
		</div>

		<table id="budgetTable">
			<thead>
				<th style="text-align: left">CHART OF ACCOUNTS</th>
				<th style="width:100px">SDA<br/>CODES</th>
				<th style="width:100px">BAL<br/>B/F</th>
				<th style="width:100px; text-align: center">QUARTER<br/>BUDGET</th>
				<th style="width:80px">YEAR<br/>BUDGET</th>
			</thead>

			<tbody>
				<% charts.eachWithIndex { chart, index -> %>
					<% if (chart.hasChildren) { %>
						<tr style="font-weight: bold">
							<td colspan="2">${chart.name}</td>
							<td>0.00</td>
							<td class="parent_${chart.id}">0.00</td>
							<td>0.00</td>
						</tr>
						
						<% chart.children.eachWithIndex { child, idx -> %>
							<tr>
								<td>&nbsp; &mdash; ${child.name}</td>
								<td style="text-align: center">${child.code}</td>
								<td>0.00</td>
								<td class="textable"><input type="text" class="child" data-uuid="${chart.id}" name="item.${child.id}"/></td>
								<td>0.00</td>
							</tr>						
						<% } %>
						
					<% } else { %>
						<tr>
							<td>${chart.name}</td>
							<td>${chart.code}</td>
							<td>0.00</td>
							<td class="textable"><input type="text" name="item.${chart.id}"/></td>
							<td>0.00</td>
						</tr>
					<% } %>
				<% } %>
				
				<tr style="font-weight: bold; font-size: 1.2em">
					<td colspan="2">TOTALS</td>
					<td>0.00</td>
					<td style="padding:0"><input id="totals" type="text" name="budget.amount" value="0.00" readonly="" /></td>
					<td>0.00</td>
				</tr>
			</tbody>
		</table>
		
		<div style="margin: 5px 0 10px;">
			<span class="button confirm right" id="addBudget">
                <i class="icon-save small"></i>
                Save
            </span>
			
			<span class="button cancel" id="cancelButton">
                <i class="icon-remove small"></i>			
				Cancel
			</span>
		</div>
        
    </form>
</div>

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