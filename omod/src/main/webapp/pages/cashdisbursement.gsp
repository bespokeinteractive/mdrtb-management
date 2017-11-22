<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Cash Disbursements"])
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
			window.location.href = "cashrequest.page";
		});
		
		if ('${tab}' == 'approved'){
			jq('#tabs').tabs('select', 1);
		}
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
	#requestList, #approvedList {
		font-size: 14px;
		
	}
	#requestList td:nth-child(5),
	#requestList td:nth-child(6),
	#approvedList td:nth-child(6),
	#approvedList td:nth-child(7) {
		text-align: right;
	}
	#requestList td:last-child,
	#approvedList td:last-child {
		text-align: center;
	}
	td i.icon.small{
		font-size: 0.9em;
	}
	td a {
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
                <a href="financedashboard.page?view=srs">Finance</a>
            </li>

            <li>
                <i class="icon-chevron-right link"></i>
                Disbursements
            </li>
        </ul>
    </div>

    <div class="patient-header new-patient-header">
        <div class="demographics">
            <h1 class="name" style="border-bottom: 1px solid #ddd;">
                <span>CASH DISBURSEMENT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
            </h1>
        </div>

        <div id="show-icon">
            &nbsp;
        </div>

        <div id="tabs" style="margin-top: 20px!important;">
            <ul id="inline-tabs">
                <li><a href="#cashrequests">Requests</a></li>
                <li><a href="#final">Approved</a></li>

                <li id="adder" class="ui-state-default">
                    <a class="button task" style="color:#fff;">
                        <i class="icon-plus"></i>
                        Request Funds
                    </a>		
                </li>
            </ul>

            <div id="cashrequests">
                ${ui.includeFragment("mdrtbmanagement", "disbursementrequests")}
            </div>
			
			<div id="final">
                ${ui.includeFragment("mdrtbmanagement", "disbursementapproved")}
            </div>
        </div>
    </div>
</div>