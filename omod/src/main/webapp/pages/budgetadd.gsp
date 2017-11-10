<% ui.decorateWith("appui", "standardEmrPage", [title: "Add Budget"]) %>

<script>
	jq(function () {
		
		
		
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
		height: 100px;
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
                Add Budget${qtrs}
            </li>
        </ul>
    </div>

    <div class="patient-header new-patient-header">
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
			
			<div style="width: 63%;">
				<label>Facility</label>
				<select id="facility" style="width: 400px;">
					<option value="">&nbsp;</option>
					<% locations.eachWithIndex { loc, index -> %>
						<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
					<% } %>
				</select>
			</div>
			
			<div>
				<label>Quarter</label>
				<select id="qtr" style="width:70px">
					<option value="1">01</option>
					<option value="2">02</option>
					<option value="3">03</option>
					<option value="4">04</option>
				</select>
				
				<select id="yrs" style="width:157px">
					<option value="">&nbsp;</option>
					<% years.eachWithIndex { yr, index -> %>
						<option value="${yr}" ${yr==year?'selected':''}  '>${yr}</option>
					<% } %>
				</select>
			</div>
			
			<div style="width: 63%;">
				<label>Notes</label>
				<textarea></textarea>
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
							<td>0.00</td>
							<td>0.00</td>
						</tr>
						
						<% chart.children.eachWithIndex { child, idx -> %>
							<tr>
								<td>&nbsp; &nbsp; ${child.name}</td>
								<td style="text-align: center">${child.code}</td>
								<td>0.00</td>
								<td>0.00</td>
								<td>0.00</td>
							</tr>						
						<% } %>
						
					<% } else { %>
						<tr>
							<td>${chart.name}</td>
							<td>${chart.code}</td>
							<td>0.00</td>
							<td>0.00</td>
							<td>0.00</td>
						</tr>
					<% } %>
				<% } %>
			</tbody>
		</table>
        
    </div>
	
</div>