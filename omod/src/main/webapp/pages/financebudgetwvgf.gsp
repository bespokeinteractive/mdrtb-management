<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Budget"])
	ui.includeCss("uicommons", "datatables/dataTables_jui.css")
	ui.includeJavascript("mdrtbregistration", "jq.dataTables.min.js")
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	var eAction;

    var refreshInTable = function (resultData, dTable) {
        var rowCount = resultData.length;
        if (rowCount == 0) {
            dTable.find('td.dataTables_empty').html("No Records Found");
        }
        dTable.fnPageChange(0);
    };

    var isTableEmpty = function (resultData, dTable) {
        if (resultData.length > 0) {
            return false
        }
        return !dTable || dTable.fnGetNodes().length == 0;
    };
	
	jq(function () {
		jq("#tabs").tabs();
		
		jq('#adder').click(function(){
			window.location.href = "budgetadd.page";
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
	#adder {
		border: 1px none #88af28;
		box-shadow: none;
		color: #fff !important;
		float: right;
		margin-right: 10px;
		margin-top: 5px;
	}
	#inline-tabs {
		background: #f9f9f9 none repeat scroll 0 0;
	}
	.dashboard {
		border: 1px solid #eee;
		margin-bottom: 5px;
		padding: 2px 0 0;
	}
	.dashboard .info-section {
		margin: 2px 5px 5px;
	}
	.dashboard .info-header i {
		font-size: 2.5em !important;
		margin-right: 0;
		padding-right: 0;
	}
	input[type="text"], select {
		border: 1px solid #aaa;
		border-radius: 2px !important;
		box-shadow: none !important;
		box-sizing: border-box !important;
		height: 37px;
		padding-left: 5px;
	}
	#draftList, #finalList {
		font-size: 14px;
		
	}
	#draftList td:nth-child(5){
		text-align: right;
	}
	#finalList td:nth-child(6) {
		text-align: right;
	}
	#draftList td:nth-child(6),
	#finalList td:nth-child(7) {
		text-align: center;
	}
</style>

<div class="clear"></div>

<div class="container">
    <div class="example">
        <ul id="breadcrumbs">
            <li>
                <a href="${ui.pageLink('referenceapplication', 'home')}">
                    <i class="icon-home small"></i></a>
            </li>

            <li>
                <i class="icon-chevron-right link"></i>
                <a href="financedashboard.page?view=wvgf">Finance</a>
            </li>

            <li>
                <i class="icon-chevron-right link"></i>
                Budget
            </li>
        </ul>
    </div>

    <div class="patient-header new-patient-header">
        <div class="demographics">
            <h1 class="name" style="border-bottom: 1px solid #ddd;">
                <span>WVGF FINANCE BUDGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
            </h1>
        </div>

        <div id="show-icon">
            &nbsp;
        </div>

        <div id="tabs" style="margin-top: 20px!important;">
            <ul id="inline-tabs">
                <li><a href="#draft">Budget Requests</a></li>
                <li><a href="#final">Budgets Approved</a></li>
            </ul>

            <div id="draft">
                ${ui.includeFragment("mdrtbmanagement", "budgetrequestwvgf")}
            </div>
			
			<div id="final">
                ${ui.includeFragment("mdrtbmanagement", "budgetapprovedwvgf")}
            </div>
        </div>
    </div>
</div>