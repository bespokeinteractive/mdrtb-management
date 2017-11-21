<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Income & Expenditure Statement"])
%>

<style>
	#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
		text-decoration: none;
	}
	body {
		margin-top: 20px;
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
	.name {
		color: #f26522;
	}
	@media all and (max-width: 768px) {
		.onerow {
			margin: 0 0 100px;
		}
	}
	.ui-widget-content a {
		color: #007fff;
	}
	#itemList th,
	#itemList td{
		text-align: center;
	}
	#itemList td:first-child{
		text-align: left;
	}
	#itemList{
		margin-top: 2px;
		font-size: 14px;
	}
	span.underline{
		border-bottom: 1px solid #f00;
		display: inline-block;
		min-width: 100px;
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
			<span><i class="icon-file-alt small"></i>STATEMENT OF INCOME & EXPENDITURES PER BUDGET LINES &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>
</div>

<table>
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
        <th rowspan=2></th>
        <th rowspan=2><small>A<br/>BAL<br/>B/F</small></th>
        <th colspan="4" style="alignment: center"> <small>FUND RECEIVED </small></th>
        <th rowspan=2><small>B<br/>TOTAL<br/>INCOME</small></th>
        <th colspan=4> <small>EXPENDITURES</small></th>
        <th rowspan=2><small>C<br/>TOTAL<br/>EXPENSES</small></th>
        <th rowspan=2><small>D<br/>BAL<br/>C/F</small></th>
    </tr>
    <tr>
        <th><small>Q1</small></th>
        <th><small>Q2</small></th>
        <th><small>Q3</small></th>
        <th><smalL>Q4</small></th>
        <th><small>Q1</small></th>
        <th><small>Q2</small></th>
        <th><small>Q3</small></th>
        <th><smalL>Q4</small></th>
    </tr>
	
	<tbody>
		<tr style="font-weight: bold">
			<td><small>GROSS TOTAL</small></td>
			<td><small>0</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)budgetQ1)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)budgetQ2)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)budgetQ3)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)budgetQ4)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)budgetTT)}</small></td>				
			<td><small>${String.format("%1\$,.2f", (Double)expenditureQ1)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)expenditureQ2)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)expenditureQ3)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)expenditureQ4)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)expenditureTT)}</small></td>
			<td><small>${String.format("%1\$,.2f", (Double)budgetTT-expenditureTT)}</small></td>
		</tr>
		
		<% charts.eachWithIndex { chart, idx -> %>
			<tr>
				<td><small>${chart.name}</small></td>
				<td><small>0</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ1)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ2)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ3)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ4)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetTT)}</small></td>				
				<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ1)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ2)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ3)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ4)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureTT)}</small></td>
				<td><small>${String.format("%1\$,.2f", (Double)chart.budgetTT-chart.expenditureTT)}</small></td>
			</tr>
		<% } %>
		
		<tr>
			<td colspan="13">&nbsp;</td>
		</tr>
		
		<% charts.eachWithIndex { chart, index -> %>
			<% if (chart.hasChildren == true) { %>
				<tr style="font-weight: bold; color: #00f;">
					<td><small>${chart.name.toUpperCase()}</small></td>
					<td><small>-</small></td>
					<td><small>-</small></td>
					<td><small>-</small></td>
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
						<td><small>0</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.budgetQ1)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.budgetQ2)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.budgetQ3)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.budgetQ4)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.budgetTT)}</small></td>				
						<td><small>${String.format("%1\$,.2f", (Double)child.expenditureQ1)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.expenditureQ2)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.expenditureQ3)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.expenditureQ4)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.expenditureTT)}</small></td>
						<td><small>${String.format("%1\$,.2f", (Double)child.budgetTT-child.expenditureTT)}</small></td>
					</tr>
				<% } %>
				
				<tr style="font-weight: bold;">
					<td><small>SUBTOTAL</small></td>
					<td><small>0</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ1)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ2)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ3)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.budgetQ4)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.budgetTT)}</small></td>				
					<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ1)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ2)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ3)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureQ4)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.expenditureTT)}</small></td>
					<td><small>${String.format("%1\$,.2f", (Double)chart.budgetTT-chart.expenditureTT)}</small></td>
				</tr>
				
				<tr>
					<td colspan="11">&nbsp;</td>
				</tr>				
			<% } %>			
		<% } %>	
	</tbody>
</table>

<table style="margin: 5px 0 15px 0">
    <tr>
        <td>
			<div style="font-weight:bold; margin-bottom:5px; padding-left:10px"><small>NOTES</small></div> 
            <small>1. Edit and update Description of budgetlines that are specific to your organisation under the budget categories.</small><br/>
            <small>2. This ia a consolidated report.</small><br/><br/>
            </small>
		</td>
	</tr>
</table>