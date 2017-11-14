<script>
	var requestTable;
	var requestTableObject;
	var requestResultsData = [];
	
	var getDisbursementRequest = function(){
        requestTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		
		var requestData = {
			draft:	true
		}
		
		jq.getJSON('${ ui.actionLink("mdrtbmanagement", "financebudget", "listCurrentBudgets") }', requestData)
			.success(function (data) {
                updateCashDisbursementResults(data);
			}).error(function (xhr, status, err) {
            updateCashDisbursementResults([]);
			}
		);
	};
	
	var updateCashDisbursementResults = function(results){
        requestResultsData = results || [];
		var dataRows = [];
		_.each(requestResultsData, function(result){
			var facility = '<a href="budgetedit.page?id=' + result.id + '">' + result.location.name + '</a>';
			var icons = '<a href="budgetedit.page?id=' + result.id + '">Edit</a> | <a href="budgetview.page?id=' + result.id + '">View</a>';
			
			dataRows.push([0, result.dated, result.period, facility, result.amount.toString().formatToAccounting(), icons]);
		});

        requestTable.api().clear();
		
		if(dataRows.length > 0) {
            requestTable.fnAddData(dataRows);
		}

		refreshInTable(requestResultsData, requestTable);
	};

    jq(function () {
        requestTableObject = jq("#disbursementrequestlist");

        requestTable = requestTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Requests",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Requests Found",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Budgets)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(requestResultsData, requestTable)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});

        requestTable.on( 'order.dt search.dt', function () {
            requestTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#drugName').on('keyup', function () {
            requestTable.api().search( this.value ).draw();
		});

        getDisbursementRequest();
    });
</script>

<div class="dashboard clear">
    <div class="info-section">
        <div class="info-header">
            <i class="icon-filter"></i>
            <h3 class="name">Requests</h3>
			<input id="drugName" type="text" value="" name="drugName" placeholder="Filter Requests" style="width:78%; margin:-40px 5px 0px 10px; padding:0px 15px;">
        </div>
    </div>
</div>

<table id="disbursementrequestlist">
    <thead>
		<th style="width:1px">#</th>
		<th style="width:100px">DATE</th>
		<th style="width:100px">QUARTER</th>
		<th>SUB-RECIPIENT</th>
	    <th style="text-align: right; width: 80px;">ESTIMATE</th>
		<th style="width:125px; text-align: right">ACTUAL <br/> AMOUNT</th>
		<th style="width:80px">ACTIONS</th>
    </thead>

    <tbody>    
    </tbody>
</table>