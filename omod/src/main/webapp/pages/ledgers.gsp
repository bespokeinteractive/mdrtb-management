<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "View Ledger"])
	ui.includeCss("uicommons", "datatables/dataTables_jui.css")
	ui.includeJavascript("mdrtbregistration", "jq.dataTables.min.js")
	ui.includeJavascript("mdrtbdashboard", "moment.js")

%>

<script>
	var ledgerTable;
    var ledgerTableObject;
    var ledgerResultsData = [];

    var getLedgerEntries = function(){
        ledgerTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');

        var requestData = {
            location:	jq('#locations').val()
        }

        jq.getJSON('${ ui.actionLink("mdrtbmanagement", "Ledgers", "getLedgerEntries") }', requestData)
            .success(function (data) {
                updateLedgerEntriesResults(data);
            }).error(function (xhr, status, err) {
                updateLedgerEntriesResults([]);
            }
        );
    };
	
	var updateLedgerEntriesResults = function(results){
        ledgerResultsData = results || [];
        var dataRows = [];
        _.each(ledgerResultsData, function(result){
			var amount = result.order==1?result.amount.toString().formatToAccounting():('('+result.amount.toString().formatToAccounting()+')');
            dataRows.push([0, result.date, result.period, result.location.name.toUpperCase(), result.item.name.toUpperCase(), result.description==''?'N/A':result.description.toUpperCase(), amount]);
        });

        ledgerTable.api().clear();

        if(dataRows.length > 0) {
            ledgerTable.fnAddData(dataRows);
        }

        refreshInTable(ledgerResultsData, ledgerTable);
    };
	
	jq(function () {
        ledgerTableObject = jq("#ledgerTable");

        ledgerTable = ledgerTableObject.dataTable({
            autoWidth: false,
            bFilter: true,
            bJQueryUI: true,
            bLengthChange: false,
            iDisplayLength: 25,
            sPaginationType: "full_numbers",
            bSort: false,
            sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
            oLanguage: {
                "sInfo": "_TOTAL_ Ledger Entries",
                "sInfoEmpty": " ",
                "sZeroRecords": "No Ledger Entries Found",
                "sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Entries)",
                "oPaginate": {
                    "sFirst": "First",
                    "sPrevious": "Previous",
                    "sNext": "Next",
                    "sLast": "Last"
                }
            },

            fnDrawCallback : function(oSettings){
                if(isTableEmpty(ledgerResultsData, ledgerTable)){
                    return;
                }
            },

            fnRowCallback : function (nRow, aData, index){
                return nRow;
            }
        });

        ledgerTable.on( 'order.dt search.dt', function () {
            ledgerTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
                cell.innerHTML = i+1;
            } );
        }).api().draw();

        jq('#filter').on('keyup', function () {
            ledgerTable.api().search( this.value ).draw();
        });
		
		//End of Datatables
		
		var expenseDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#expense-dialog',
            actions: {
                confirm: function () {
					var amount = jq('#amount').val().replace(',','').replace(' ','');;
					if (jq('#items').val() == ''){
						jq().toastmessage('showErrorToast', 'Invalid expenditure item/entry. Kindly correct and try again');
						jq('#amount').focus();
						return false;
					}
					if (isNaN(parseFloat(amount)) || isFinite(amount) && amount == 0) {
						jq().toastmessage('showErrorToast', 'Invalid expenditure amount specified. Kindly correct');
						jq('#amount').focus();
						return false;
					}
			
                    var dataString = {
						amount:		amount,
						item: 		jq('#items').val(),
						date: 		jq('#date-field').val(),
						notes: 		jq('#notes').val(),
						location:	jq('#facility').val(),
					}

                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbmanagement", "Ledgers", "postExpenditure")}',
                        data: dataString,
                        dataType: "json",
                        success: function (data) {
                            if (data.status == "success") {
                                jq().toastmessage('showSuccessToast', data.message);
                                window.location.href = "ledgers.page?index=" + jq('#locations').val();
                            }
                            else {
                                jq().toastmessage('showErrorToast', 'Post failed. ' + data.message);
                            }
                        },
                        error: function (data) {
                            jq().toastmessage('showErrorToast', "Post failed. " + data.statusText);
                        }
                    });

                    expenseDialog.close();
                },
                cancel: function () {
                    expenseDialog.close();
                }
            }
        });
		
		jq('#amount').change(function() {
			var val = jq(this).val().replace(',','').replace(' ','');
			jq(this).val(val.toString().formatToAccounting()!='NaN'?val.toString().formatToAccounting():'');
		});
		
		jq('#amount').focus(function() {
			var val = jq(this).val().replace(',','').replace(' ','');;
			if (isNaN(parseFloat(val)) || isFinite(val) && val == 0) {
				jq(this).val('');
			}
		});
		
		jq('#addLedger').click(function(){
			expenseDialog.show();
		});

		jq('#locations').change(function(){
			getLedgerEntries();
		});
		
		jq('#locations').val(${index});

        getLedgerEntries();
    });
	

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
	#ledgerTable{
		font-size: 12px;
		margin-top: 5px;
	}
	#ledgerTable th:last-child,
	#ledgerTable td:last-child{
		text-align: right;
	}
	#ledgerTable td:first-child{
		text-align: center;
	}
	#filter {
		margin-right:3px;
	}
	#addLedger{
		padding: 13px 7px;
		margin-right: 5px;
		margin-left: 3px;
	}
	.icon-filter.small.right{
		font-size: 1.6em;
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
		width: 70%;
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
            Legder
        </li>
    </ul>
</div>

<div class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-bookmark-empty small"></i>FINANCIAL LEDGER &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div id="show-icon">
		<span class="button confirm right" id="addLedger">
			<i class="icon-plus small"></i>
		</span>
		
		<select id="locations" class="right" style="width:200px;">
			<option value="-1">All</option>
			<% locations.eachWithIndex { loc, index -> %>
				<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
			<% } %>
		</select>
		
		<input id="filter" class="right" placeholder="Filter Records" />
		<i class="icon-filter small right"></i>
		
		<div class="clear both"></div>
	</div>

	<div class="budget-box">
		
	</div>
	
	<table id="ledgerTable">
		<thead>
			<th style="width:1px">#</th>
			<th style="width:70px;">DATE</th>
			<th style="width:45px;">PERIOD</th>
			<th style="width:120px;">FACILITY</th>
			<th style="width:180px;">JOURNAL</th>
			<th>NARRATION</th>
			<th style="width:100px">AMOUNT</th>
		</thead>

		<tbody>
		</tbody>
	</table>

	<div style="margin: 5px 0 10px;">
		<span class="button task right" id="addRequest">
			<i class="icon-print small"></i>
			Print
		</span>
	</div>
</div>

<div id="expense-dialog" class="dialog" style="display:none; width:600px">
    <div class="dialog-header">
        <i class="icon-bar-chart"></i>
        <h3>ADD EXPENDITURE</h3>
    </div>

    <div class="dialog-content">
		<ul>
			<li>
				<label for="facility">FACILITY :</label>
				<select type="text" id="facility">
					<% locations.eachWithIndex { loc, index -> %>
						<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
					<% } %>
				</select>
			</li>
			
			<li>
				<label for="items">ITEM :</label>
				<select type="text" id="items">
					<option value="">...</option>
					<% charts.eachWithIndex { chart, index -> %>
						<% if (chart.hasChildren) {%>
							<optgroup label="${chart.name}">
								<% chart.children.eachWithIndex { child, idx -> %>
									<option value="${child.id}">${child.name}</option>
								<% } %>
							</optgroup>
						<% } else { %>
							<option value="${chart.id}">${chart.name}</option>
						<% } %>
					<% } %>
				</select>
			</li>

			<li>
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'confirm.date', id: 'date', label: 'DATE:', useTime: false, defaultToday: true])}
			</li>
			
			<li>
				<label for="amount">AMOUNT:</label>
				<input type="text" id="amount"/>
			</li>

			<li>
				<label for="notes">NARRATION:</label>
				<textarea id="notes" placeholder="Narration"></textarea>
			</li>
		</ul>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>