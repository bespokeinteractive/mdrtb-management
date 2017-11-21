<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Ledger Summary"])
%>

<style>
     table th, table td {
         text-align: left;
         white-space: nowrap;
     }
	#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
		text-decoration: none;
	}
	body {
		margin-top: 20px;
	}
	form input{
		margin: 0px;
		display: inline-block;
		min-width: 50px;
		padding: 2px 10px;
	}
	.info-header span{
		cursor: pointer;
		display: inline-block;
		float: right;
		margin-top: -2px;
		padding-right: 5px;
	}
	.dashboard .info-section {
		margin: 2px 5px 5px;
	}
	.toast-item{
		background-color: #222;
	}
	form input:focus, form select:focus, form textarea:focus, form ul.select:focus, .form input:focus, .form select:focus, .form textarea:focus, .form ul.select:focus{
		outline: 1px none #007fff;
		box-shadow: 0 0 1px 0px #888!important;
	}
	.name {
		color: #f26522;
	}
	@media all and (max-width: 768px) {
		.onerow {
			margin: 0 0 100px;
		}
	}
	form .advanced {
		background: #363463 none repeat scroll 0 0;
		border-color: #dddddd;
		border-style: solid;
		border-width: 1px;
		color: #fff;
		cursor: pointer;
		float: right;
		padding: 5px 0;
		text-align: center;
		width: 18%;
	}
	form .advanced i{
		font-size: 24px;
	}
	.add-on {
		float: right;
		left: auto;
		margin-left: -29px;
		margin-top: 5px;
		position: absolute;
		color: #f26522;
	}
	.ui-widget-content a {
		color: #007fff;
	}
	td a{
		cursor: pointer;
		text-decoration: none;
	}
	td a:hover{
		text-decoration: none;
	}
	.recent-seen{
		background: #fff799 none repeat scroll 0 0!important;
		color: #000 !important;
	}
	.recent-lozenge {
		border: 1px solid #f00;
		border-radius: 4px;
		color: #f00;
		display: inline-block;
		font-size: 0.7em;
		padding: 1px 2px;
		vertical-align: text-bottom;
	}
	table th, table td {
		white-space: nowrap;
	}
	.dialog-content ul li input[type="text"],
	.dialog-content ul li input[type="password"],
	.dialog-content ul li select,
	.dialog-content ul li textarea {
		border: 1px solid #ddd;
		display: inline-block;
		height: 40px;
		margin: 1px 0;
		min-width: 20%;
		padding: 5px 0 5px 10px;
		width: 68%;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.3 !important;
	}
	form label,
	.form label {
		display: inline-block;
		width: 110px;
	}
	.dialog select option {
		font-size: 1em;
	}
	.dialog .dialog-content li {
		margin-bottom: 0;
	}
	.dialog ul {
		margin-bottom: 10px;
	}
	label.user-locations input{
		margin-top: 4px;
	}
	.select-report{
		cursor: pointer;
	}
	.report-container {
		margin: 10px 0px;
	}
	p.reportTitle{
		font-family: "OpenSansBold";
		margin: 10px 0;
		text-align: center;
	}
	span.underline{
		border-bottom: 1px solid #f00;
		display: inline-block;
		min-width: 100px;
	}
	#itemList th,
	#itemList td{
		text-align: center;
	}
	#itemList td:first-child{
		text-align: left;
	}
	#itemList{
		font-size: 14px;
		margin-top: 2px;
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
            <a>Ledgers Summary</a>
        </li>
    </ul>
</div>

<div class="patient-header new-patient-header" style="margin-bottom: 1px;">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-file-alt small"></i>SOMALIA TUBERCULOSIS CARE AND CONTROL PROGRAM &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>
</div>

<table id="tb1">
    <tr>
        <td style="font-weight: bold; font-size: 0.9em; text-align: right; width: 209px;">
			AGENCY NAME :<br/>
			CONTRACT NUMBER :<br/>
			REPORTING PERIOD : <br/>
			TB CENTER :<br/>
        </td>

        <td>
			<span class="underline" style="width: 400px"><small>&nbsp; ${centre.agency.name.toUpperCase()}</small></span><br/>
			<span class="underline" style="width: 400px"><small>&nbsp; N/A</small></span><br/>
			<span class="underline" style="width: 400px"><small>&nbsp; ${start} to ${ended}</small></span><br/>
			<span class="underline" style="width: 400px"><small>&nbsp; ${centre.location.name.toUpperCase()}<small></span><br/>
        </td>
    </tr>
</table>

<table id="itemList">
    <tr>
        <th><small></small></th>
        <th><small>SDA<br/>CODES<br/>&nbsp;</small></th>
        <th><small>QUARTER<br/>BUDGET<br/>US \$</small></th>
        <th><small>QUARTER<br/>ACTUAL<br/>US \$</small></th>
        <th><small>QUARTER<br>VARIANCE<br/>US \$</small></th>
        <th><small>QUARTER<br> VARIANCE<br/>%</small></th>
        <th><small>VARIENCE<br>EXPLANATION<br>&nbsp;</small></th>
        <th><small>Y.T.D <br> BUDGET<br>US \$</small></th>
        <th><small>Y.T.D <br> ACTUAL<br>US \$</small></th>
        <th><small>Y.T.D <br> VARIANCE<br>US \$</small></th>
        <th><small>ANNUAL <br> BUDGET<br>US \$</small></th>

    </tr>
	
    <tr style="font-weight: bold">
        <td><small>GROSS TOTAL</small></td>
        <td><small>&nbsp;</small></td>
        <td><small>${String.format("%1\$,.2f", (Double)budget)}</small></td>
		<td><small>${String.format("%1\$,.2f", (Double)expenditure)}</small></td>
		<td><small>${String.format("%1\$,.2f", (Double)variance)}</small></td>
		<td><small>${String.format("%1\$,.2f", (Double)percentage)}%</small></td>
		<td><small>-</small></td>
		<td><small>${String.format("%1\$,.2f", (Double)budgetYT)}</small></td>
		<td><small>${String.format("%1\$,.2f", (Double)expenditureYT)}</small></td>
		<td><small>${String.format("%1\$,.2f", (Double)budgetYT-expenditureYT)}</small></td>
		<td><small>${String.format("%1\$,.2f", (Double)budgetTT)}</small></td>
    </tr>
	
	<% charts.eachWithIndex { chart, idx -> %>
		<tr>
			<td><small>${chart.name}</small></td>
			<td><small>${chart.code}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.budget)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.expenditure)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.variance)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.percentage)}%</small></td>
			<td><small>-</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.budgetYT)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureYT)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.budgetYT-chart.expenditureYT)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)chart.budgetTT)}</small></td>
		</tr>
	<% } %>
	
	<tr>
		<td colspan="11">&nbsp;</td>
	</tr>
	
	<% charts.eachWithIndex { chart, index -> %>
		<% if (chart.hasChildren == true) { %>
			<tr style="font-weight: bold; color: #00f;">
				<td><small>${chart.name.toUpperCase()}</small></td>
				<td><small>${chart.code}</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
				<td><small>-</small></td>
			</tr>
			
			<% chart.children.eachWithIndex { child, idx -> %>
				<tr>
					<td><small>&nbsp; ${child.name}</small></td>
					<td><small>${child.code}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.budget)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.expenditure)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.variance)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.percentage)}%</small></td>
					<td><small>-</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.budgetYT)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.expenditureYT)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.budgetYT-child.expenditureYT)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)child.budgetTT)}</small></td>
				</tr>
			<% } %>
			
			<tr style="font-weight: bold;">
				<td><small>SUBTOTAL</small></td>
				<td><small>&nbsp;</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budget)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.expenditure)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.variance)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.percentage)}%</small></td>
				<td><small>-</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetYT)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureYT)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetYT-chart.expenditureYT)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetTT)}</small></td>
			</tr>
			
			<tr>
				<td colspan="11">&nbsp;</td>
			</tr>
			
		<% } %>
		
	<% } %>
</table>

<table style="margin: 5px 0 15px 0">
    <tr>
        <td>
			<div style="font-weight:bold; margin-bottom:5px; padding-left:10px"><small>NOTES</small></div> 
            <small>1.Edit budget descriptions that are specific to your organisation under the budget categories</small><br/>
            <small>2.For variance over +/- 10% variance explanations are required.</small> <br/>
            <small>3.This report should be done for each TB centre respectively and a subsequently consolidated into 1 report.<br/><br/>
            </small>
		</td>
	</tr>
</table>







