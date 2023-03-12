<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="StaffType.aspx.cs" Inherits="Admin_StaffType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="w-full my-5 text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5 shadow-2xl space-y-3">
        <div class="">
            <div>
                <h1 class="text-5xl">Staff Type</h1>
            </div>
        </div>
        <div class="font-poppins-400 capitalize text-gray-400 font-bold capitalize">
            <div><span class="capitalize">Staff > Staff Type</span></div>
        </div>
    </div>


    <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
        <div class="w-full">
            <div class="font-poppins-400 text-xl w-full space-y-10 font-bold">

                <!-- Fields -->
                <div class="flex space-x-5 w-full">

                    <lable for="" class="my-auto">Staff Type</lable>
                    <input id="txtStaffType" placeholder="--Staff Type--" class="bg-transparent  border w-full border-classic-dimyellow w-1/2 py-1 px-1"  type="text" />
                </div>
                <input id="hdnStaffTypeID" type="hidden" />
                <!-- Fields End-->

                <!-- Buttons -->
                <div class="flex space-x-10">
                    <div class="">
                        <input id="btnSave" class="bg-yellow-900 text-white py-3 px-10 hover:bg-yellow-700 cursor-pointer" type="button" value="Save" />
                    </div>
                    <div>
                        <input id="btnClear" class="border border-yellow-900 text-yellow-900 py-3 px-10 hover:bg-amber-600 hover:text-white cursor-pointer" type="button" value="Clear" />
                    </div>
                </div>
                <!-- Buttons End-->


            </div>
        </div>

    </div>
    <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
        <table class=" dataTable" id="tblStaffType">
            <thead>
                <tr>
                    <th>SR.No</th>
                    <th>Staff Type</th>
                    <th class="flex">Actions</th>
                </tr>
            </thead>
             <tbody>
                <tr>
                    <th>SR.No</th>
                    <th>Staff Type</th>
                    <th class="flex">Actions</th>
                </tr>
            </tbody>
             <tfoot>
                <tr>
                    <th>SR.No</th>
                    <th>Staff Type</th>
                    <th class="flex">Actions</th>
                </tr>
            </tfoot>
        </table>
    </div>
    <script>
/*const { Swal } = require("./jquery/sweetalert2@11");*/

        var table;
        // Page Load
        $(function () {
            
            table = $("#tblStaffType").DataTable({
                responsive: true,
                autoWidth: false,
                'deferRender': true
            });
           FillStaffTypeData(0);
        })
        // Clear Function
        function ClearData() {
            $("#txtStaffType").val("");
            $("#hdnStaffTypeID").val("");
        }
        //On Save
        $("#btnSave").on("click", function () {
            var StaffType = $("#txtStaffType");
            var StaffTypeID = $("#hdnStaffTypeID");

            if (StaffType.val() == "") {
                Swal.fire('Invalid Name', 'Provide Staff Type', 'error')
                //alert("Provide Category Name");
                StaffType.focus();
                return false;
            } else {

                var StaffTypeID = StaffTypeID.val() == "" ? 0 : StaffTypeID.val();
                var StaffType = StaffType.val().trim();
                $.ajax({
                    url: "Webservices/StaffTypeWebService.asmx/StaffTypeMasterManage",
                    method: "POST",
                    data: '{StaffTypeID: ' + JSON.stringify(StaffTypeID) + ', StaffType: ' + JSON.stringify(StaffType) + ' }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (res) {
                        var result = res.d;
                        if (result.includes("Error")) {
                            console.log(result);
                        }
                        else if (result.includes("Success")) {

                            if (result.includes("Saved")) {
                                ClearData();
                                Swal.fire('Saved', result, 'success')
                                FillStaffTypeData(0);
                            }
                            else {
                                
                                ClearData();
                                Swal.fire('Updated', result, 'success')
                                FillStaffTypeData(0);
                            }

                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
            }
        })
        // On Delete
        function DeleteStaffType(StaffTypeID) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                background:"#27272a",
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "post",
                        url: "WebServices/StaffTypeWebService.asmx/StaffTypeMasterDelete",
                        data: '{StaffTypeID: ' + JSON.stringify(StaffTypeID) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = response.d;
                            if (result.includes("Error")) {
                                console.log(result);
                            } else {
                                Swal.fire('Deleted!',result,'success')
                                FillStaffTypeData(0);
                            }
                        },
                        error: function (err) {
                            var e = err.d;
                            console.log(e);
                        }
                    })
                }
            })
        }
        // On Update

        function EditStaffType(StaffTypeID) {
            $.ajax({
                url: "Webservices/StaffTypeWebService.asmx/StaffTypeMasterGet",
                method: "POST",
                data: '{StaffTypeID: ' + JSON.stringify(StaffTypeID) + ' }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnEditSuccess,
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function OnEditSuccess(response) {
           
            $("#btnSave").text("Update");
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Details = xml.find("DataDetails");

            $("[id=hdnStaffTypeID]").val(Details.find("StaffTypeID").text());
            $("[id=txtStaffType]").val(Details.find("StaffType").text());

            $("[id=txtStaffType]").focus();

        }
        // Fill Table
        function FillStaffTypeData(StaffTypeID) {
            $.ajax({
                url: "Webservices/StaffTypeWebService.asmx/StaffTypeMasterGet",
                method: "POST",
                data: '{StaffTypeID: ' + JSON.stringify(StaffTypeID) + ' }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function OnSuccess(response) {
            var XmlDoc = $.parseXML(response.d);
            var xml = $(XmlDoc);
            var Details = xml.find("DataDetails");

            table.clear();

            if (Details.length > 0) {
                $.each(Details, function () {
                    var strEditDelete = "";
                    strEditDelete += "<input id=\"btnEdit\" type=\"button\" value=\"Edit\" onclick=\"EditStaffType(" + $(this).find("StaffTypeID").text() + ");\" class=\"mx-2 bg-yellow-900 text-white py-3 px-10 hover:bg-yellow-700 cursor-pointer\">";
                    strEditDelete += "<input id=\"btnDelete\" type=\"button\" value=\"Delete\" onclick=\"DeleteStaffType(" + $(this).find("StaffTypeID").text() + ");\" class=\"bg-red-900 text-white py-3 px-10 hover:bg-red-700 cursor-pointer\">";

                    table.row.add([
                        $(this).find("RowNumber").text(),
                        $(this).find("StaffType").text(),
                        strEditDelete
                    ]).draw(false);
                })
            } else {
                table.clear().draw(false);
            }
        }
    </script>

</asp:Content>

