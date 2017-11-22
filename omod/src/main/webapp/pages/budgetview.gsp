<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "View Budget"])
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
		width: 60px;
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
	.show-icon {
		float: right;
		font-family: "OpenSansBold";
		font-size: 1.5em;
		margin: 0 0 -5px 0;
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
			<a href="financebudget.page">Budget</a>
		</li>

		<li>
			<i class="icon-chevron-right link"></i>
			View Budget
		</li>
	</ul>
</div>

<div class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-paste small"></i>VIEW BUDGET &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div class="show-icon">
		<i class="icon-globe small"></i>${budget.location.name.toUpperCase()}&nbsp;
	</div>
	<div class="clear both"></div>
	
	<div class="budget-box">
		<div>
			<Label>Date</Label>${ui.formatDatePretty(budget.dated)}
		</div>
		
		<div style="width: 63%; float: right">
			<label style="display: inline-block">Notes</label>${budget.description==''?'N/A':budget.description}
		</div>
		
		<div>
			<label>Quarter</label>${budget.period}
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
			<th style="width:120px">COMMENTS<br/>&nbsp;</th>
		</thead>

		<tbody>
			<% charts.eachWithIndex { chart, index -> %>
				<% if (chart.value > 0){ %>
					<% if (chart.hasChildren) { %>
						<tr style="font-weight: bold">
							<td>${chart.name}</td>
							<td>-</td>
							<td>0.00</td>
							<td>${String.format("%1\$,.2f",chart.value)}</td>
							<td>${String.format("%1\$,.2f",chart.budget)}</td>
							<td>-</td>
						</tr>
						
						<% chart.children.eachWithIndex { child, idx -> %>
							<% if (child.value > 0){ %>
								<tr>
									<td>&nbsp; &mdash; ${child.name}</td>
									<td>${child.code}</td>
									<td>0.00 &nbsp; &nbsp;</td>
									<td>${String.format("%1\$,.2f",child.value)} &nbsp; &nbsp;</td>
									<td>${String.format("%1\$,.2f",child.budget)} &nbsp; &nbsp;</td>
									<td>${child.comment?child.comment:'N/A'}</td>
								</tr>
							<% } %>
						<% } %>
					<% } else { %>
						<tr>
							<td>${chart.name}</td>
							<td>${chart.code}</td>
							<td>0.00</td>
							<td>${String.format("%1\$,.2f",chart.value)}</td>
							<td>${String.format("%1\$,.2f",chart.budget)}</td>
							<td>${chart.comment?chart.comment:'N/A'}</td>
						</tr>
					<% } %>
				<% } %>
			<% } %>
		</tbody>
	</table>
	
	<div style="margin: 5px 0 10px;">
		<span class="button task right" id="addBudget">
			<i class="icon-save small"></i>
			Print
		</span>
	</div>
</div>