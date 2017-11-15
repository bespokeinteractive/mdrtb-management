<% ui.decorateWith("appui", "standardEmrPage", [title: "View Budget"])
ui.decorateWith("appui", "standardEmrPage", [title: "Add Request"])
ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
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
</script>
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
            Add Request
        </li>
    </ul>
</div>

<form class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-paste small"></i>ADD REQUEST &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
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
			<label>SRs</label>
			<select id="facility" name="budget.facility">
                <% locations.eachWithIndex { loc, index -> %>
                <option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
                <% } %>
			</select>
		</div>
        <div>
            <label>Qtr Estimate</label>
            <input type="text" id="estimateAmnt" name="budget.estimate">

        </div>
        <div>
            <label>Total Amount</label>
            <input type="text" id="totalAmnt" name="budget.totalAmnt">

        </div>

		<span class="clear both"></span>
	</div>

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
#modal-overlay {
    background: #000 none repeat scroll 0 0;
    opacity: 0.3 !important;
}
</style>
</div>