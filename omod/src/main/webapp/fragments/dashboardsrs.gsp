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
		width: 75px;
		font-size: 0.7em;
	}
	a.icons:hover{	
		background-color: #53bfe2;
		color: #fff;
	}
	a.icons img {
		margin-bottom: 10px;
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
	<a class="icons" href="financebudget.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-budget.png')}"><br/>
		<span>SUBRECIPIENT BUDGET</span>
	</a>
	
	<a class="icons" href="cashdisbursement.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-wallet-1.png')}"><br/>
		<span>CASH DISBURSEMENT</span>
	</a>
	
	<a class="icons" href="cashrequest.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-request.png')}"><br/>
		<span>REQUEST FUNDS</span>
	</a>
	
	<a class="icons" href="ledgers.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-profits.png')}"><br/>
		<span>FINANCIAL LEDGER</span>
	</a>
	
	<a class="icons" href="humanresource.page">
		<img src="${ui.resourceLink('mdrtbmanagement', 'images/00-meeting.png')}"><br/>
		<span>HUMAN RESOURCES</span>
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