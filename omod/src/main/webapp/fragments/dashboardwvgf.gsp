<script>
    jq(function () {
        jq('.ledger-summary').click(function(){
            jq('#reportIdnt').val(1);
            jq('#reportName').val('SUBRECIPIENT SUMMARY');
            reportDialog.show();
        });

        jq('.income-statement').click(function(){
            jq('#incomeIdnt').val(1);
            jq('#incomeName').val('INCOME/EXPENDITURE STATEMENT');
            incomeDialog.show();
        });

        jq('.ledgercashflow').click(function(){
            jq('#reportIdnt').val(2);
            jq('#reportName').val('CASHFLOW SUMMARY');
            reportDialog.show();
        });

        var reportDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#report-dialog',
            actions: {
                confirm: function() {
                    if (jq('#facility').val() == ''){
                        jq().toastmessage('showErrorToast', 'Invalid Facility. Kindly provide the correct value for the facility');
                        return false;
                    }

                    if (jq('#reportIdnt').val() == 1){
                        window.location.href = "ledgersummary.page?facility="+jq('#facility').val()+"&qtr="+jq('#qtr').val()+"&yr="+jq('#yrs').val();
                    }
                    else if (jq('#reportIdnt').val() == 2){
                        window.location.href = "ledgerscashflow.page?facility="+jq('#facility').val()+"&qtr="+jq('#qtr').val()+"&yr="+jq('#yrs').val();
                    }
                },
                cancel: function() {
                    reportDialog.close();
                }
            }
        });

        var incomeDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#income-dialog',
            actions: {
                confirm: function() {
                    if (jq('#incomeFacility').val() == ''){
                        jq().toastmessage('showErrorToast', 'Invalid Facility. Kindly provide the correct value for the facility');
                        return false;
                    }

                    if (jq('#incomeIdnt').val() == 1){
                        window.location.href = "ledgerstatement.page?facility="+jq('#incomeFacility').val()+"&yr="+jq('#incomeYear').val();
                    }
                },
                cancel: function() {
                    incomeDialog.close();
                }
            }
        });

        jq("#qtr").val(${qtrs});
    });
</script>

<style>
a.icons {
	border: 1px solid #53bfe2;
	color: #333;
	cursor: pointer;
	display: inline-block;
	margin-top: 5px;
	padding: 10px;
	text-align: center;
	text-decoration: none;
	width: 74px;
	font-size: 0.7em;
}
a.icons:hover{
	background-color: #53bfe2;
	color: #fff;
}
a.icons img {
	margin-bottom: 10px;
}
.dialog {
	width: 500px;
}
.dialog .dialog-content li {
	margin-bottom: 0;
}
.dialog-content ul li label {
	display: inline-block;
	width: 150px;
}
.dialog-content ul li input[type="text"], .dialog-content ul li select, .dialog-content ul li textarea {
	border: 1px solid #ddd;
	display: inline-block;
	height: 40px;
	margin: 1px 0;
	min-width: 20%;
	padding: 5px 0 5px 10px;
	width: 64%;
}
.dialog select option {
	font-size: 1em;
}
.dialog ul {
	margin-bottom: 20px;
}
.button.confirm {
	margin-right: 6px;
}
#modal-overlay {
	background: #000 none repeat scroll 0 0;
	opacity: 0.4!important;
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
			<a >Finance Dashboard</a>
		</li>

		<li></li>
	</ul>
</div>

<img src="${ui.resourceLink('mdrtbmanagement', 'images/banner.jpg')}" style="width: 100%">

<div>
	<a class="icons" href="financebudgetwvgf.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-budget.png')}"><br/>
		<span>VIEW BUDGETS</span>
	</a>

	<a class="icons" href="cashdisbursementwvgf.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-wallet-1.png')}"><br/>
		<span>VIEW DISBURSEMENT</span>
	</a>
	<a class="icons ledger-summary">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-stopwatch.png')}"><br/>
		<span>SUBRECIPIENT SUMMARY</span>
	</a>

	<a class="icons" href="humanresource.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-human-linked.png')}"><br/>
		<span>HUMAN RESOURCES</span>
	</a>

	<a class="icons" href="ledgers.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-profits.png')}"><br/>
		<span>FINANCIAL LEDGER</span>
	</a>
	<a class="icons" href="assets.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-coding.png')}"><br/>
		<span>ASSET REGISTERS</span>
	</a>

	<a class="icons" href="reports.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-bars.png')}"><br/>
		<span>VIEW<br/>REPORTS</span>
	</a>
</div>

<div id="report-dialog" class="dialog" style="display:none;">
	<div class="dialog-header">
		<i class="icon-folder-open"></i>
		<h3>SUMMARY DIALOG</h3>
	</div>

	<div class="dialog-content">
		<ul>
			<li>
				<label for="reportName">
					Summary Page :
				</label>
				<input type="text" id="reportName" readonly="" />
				<input type="hidden" id="reportIdnt" />
			</li>

			<li>
				<label for="">
					Quarter :
				</label>

				<select id="qtr" style="width:100px">
					<option value="1">01</option>
					<option value="2">02</option>
					<option value="3">03</option>
					<option value="4">04</option>
				</select>

				<select id="yrs" style="width:178px">
					<% years.eachWithIndex { yr, index -> %>
					<option value="${yr}" ${yr==year?'selected':''}  '>${yr}</option>
					<% } %>
				</select>
			</li>

			<li>
				<label for="facility">
					Facility :
				</label>

				<select id="facility" class="required" name="report.outcome">
					<option value="">&nbsp;</option>
					<% locations.eachWithIndex { loc, index -> %>
					<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
					<% } %>
				</select>
			</li>
		</ul>

		<label class="button confirm right">Confirm</label>
		<label class="button cancel">Cancel</label>
	</div>
</div>

<div id="income-dialog" class="dialog" style="display:none;">
	<div class="dialog-header">
		<i class="icon-folder-open"></i>
		<h3>SUMMARY DIALOG</h3>
	</div>

	<div class="dialog-content">
		<ul>
			<li>
				<label for="incomeName">
					Summary Page :
				</label>
				<input type="text" id="incomeName" readonly="" />
				<input type="hidden" id="incomeIdnt" />
			</li>

			<li>
				<label for="incomeYear">
					Year :
				</label>

				<select id="incomeYear">
					<% years.eachWithIndex { yr, index -> %>
					<option value="${yr}" ${yr==year?'selected':''}  '>${yr}</option>
					<% } %>
				</select>
			</li>

			<li>
				<label for="incomeFacility">
					Facility :
				</label>

				<select id="incomeFacility" class="required">
					<option value="">&nbsp;</option>
					<% locations.eachWithIndex { loc, index -> %>
					<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
					<% } %>
				</select>
			</li>
		</ul>

		<label class="button confirm right">Confirm</label>
		<label class="button cancel">Cancel</label>
	</div>
</div>