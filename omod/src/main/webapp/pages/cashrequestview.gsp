<%
	ui.decorateWith("appui", "standardEmrPage", [title: "View Request"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

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
            View Request
        </li>
    </ul>
</div>

<div class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-bookmark-empty small"></i>VIEW REQUEST &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div id="show-icon">
		&nbsp;
	</div>

	<div class="budget-box">
		
		
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
</div>