<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="SubCategoryMaster.aspx.cs" Inherits="Admin_SubCategoryMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <!-- Page Heading -->
    <div class="w-full my-5 text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5 shadow-2xl space-y-3">
        <div class="">
            <div>
                <h1 class="text-5xl">Sub-Category Master</h1>
            </div>
        </div>
        <div class="font-poppins-400 capitalize text-gray-400 font-bold capitalize">
            <div ><span class="capitalize"> Master > Sub-Category Master</span></div>
        </div>
    </div>
    <!-- Page Heading End -->

    <!-- Form Content -->
    <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
        <div class="w-full">
            <div class="font-poppins-400 text-xl w-full space-y-10 font-bold">
                 <!-- Image Preview -->
                <div class="grid gap-5 md:grid-cols-2">
                    <div class="flex space-x-5  w-full">
                        <label for="fuSubCategoryPhoto" class="">
                            <img id="imgSubCategoryPhoto" src="#" alt="" height="150" width="150" class="max-w-full h-auto rounded-lg " />
                            <input id="fuSubCategoryPhoto" type="file" class="hidden" />
                            <input id="hdnPhotoPath" type="hidden" class="hidden" />
                        </label>
                    </div>
                    <br />
                    <div class="px-1 justify-center">
                        <label for="imgSubCategoryPhoto">SubCategory Photo</label>
                    </div>
                </div>
                <!-- Fields -->
                <div class="grid gap-5 md:grid-cols-2 ">
                    <div class="flex space-x-5 w-full ">
                        <input id="hdnSubCategoryID" type="hidden" />
                        <lable for="dllCategory" class="w-1/2 my-auto">Category Name</lable>
                        <select id="dllCategory" class="my-6 bg-transparent py-1 px-1 border w-full border-classic-dimyellow text-center">
                            <option value="0">-- SELECT CATEGORY --</option>

                        </select>
                        
                    </div>
                    <div class="flex space-x-5 w-full">
                        <lable for="txtSubCategoryName" class="w-1/2 my-auto">Sub-Category Name</lable>
                        <input id="txtSubCategoryName" class="my-7 bg-transparent border w-full border-classic-dimyellow py-1 px-1"  type="text" />
                    </div>
                </div>
                <!-- Fields End -->

                <!-- Action buttons -->
                <div class="flex space-x-10">
                    <div class="">
                        <input id="btnSave" class="bg-yellow-900 text-white py-3 px-10 hover:bg-yellow-700 cursor-pointer" type="button" value="Save" />
                    </div>
                    <div>
                        <input id="btnClear" class="border border-yellow-900 text-yellow-900 py-3 px-10 hover:bg-amber-600 hover:text-white cursor-pointer" type="button" value="Clear" />
                    </div>
                </div>
                <!--Action Buttons End-->


            </div>
        </div>

    </div>
    <!--Form Content End-->
    <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
        <table class=" dataTable" id="tblSubCategory">
            <thead>
                <tr>
                    <th>SR.No</th>
                    <th>Category</th>
                    <th>Sub-Category </th>
                    <th>Sub-Category Photo</th>
                    <th class="flex">Actions</th>
                </tr>
            </thead>
             <tbody>
                <tr>
                   <th>SR.No</th>
                    <th>Category</th>
                    <th>Sub-Category </th>
                    <th>Sub-Category Photo</th>
                    <th class="flex">Actions</th>
                </tr>
            </tbody>
             <tfoot>
                <tr>
                   <th>SR.No</th>
                    <th>Category</th>
                    <th>Sub-Category </th>
                    <th>Sub-Category Photo</th>
                    <th class="flex">Actions</th>
                </tr>
            </tfoot>
        </table>
    </div>
    <script>
        //Global Variable
        var table;
        // Page Load
        $(function () {
            table = $("#tblSubCategory").DataTable({
                responsive: true,
                autoWidth: false,
                'deferRender': true
            });
            ListAllCategory();
            FillSubCategoryData(0);
        });
        // Clear Function
        function ClearData() {
            $("#dllCategory").val(0);
            $("#txtSubCategoryName").val("");
            $("#hdnSubCategoryID").val("");
            $("#fuSubCategoryPhoto").val('');
            $('#imgSubCategoryPhoto').prop('src', null);
        }
        $("#btnClear").on('click', function () {

            ClearData();
        });
        // List Category
        function ListAllCategory()
        {
            $.ajax({
                url: "Webservices/CategoryMasterWebService.asmx/ListAllCategory",
                method: "POST",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    var dllCategory = $("#dllCategory");
                    dllCategory.empty();
                    
                    $.each(res.d, function () {
                        dllCategory.append($("<option></option>").val(this['Value']).text(this['Text']));
                    })
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        // Image Function
        $("#fuSubCategoryPhoto").on("change", function () {
            myfile = $(this).val();
            if (myfile == '') {
                document.getElementById("imgSubCategoryPhoto").src = "";
                $("#imgSubCategoryPhoto").attr("style", "display:none");
            }
            var ext = myfile.split('.').pop();
            var str = myfile.substring(0, 10) + "." + ext;
            showFileSize(ext);
        });
        function showFileSize(ext) {
            var input, file;
            var fileUpload = $("#fuSubCategoryPhoto").get(0);
            input = document.getElementById('fuSubCategoryPhoto');
            file = fileUpload.files[0];
            var size = parseFloat($("#fuSubCategoryPhoto")[0].files[0].size / 1024).toFixed(2);

            if (size <= 500) {
                var src = URL.createObjectURL(file);
                var preview = document.getElementById("imgSubCategoryPhoto");
                preview.src = src;
                preview.style.display = "block";
            }
            else {
                Swal.fire('Size Limit', 'Provide 500kb Photo', 'error');
                $("#fuSubCategoryPhoto").val('');
            }
        }
        // Save Image
        function SaveImage() {
            var fileUpload = $("#fuSubCategoryPhoto").get(0);
            var files = fileUpload.files;
            var data = new FormData();
            var filepath = "";
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }

            if (files.length > 0) {
                $.ajax({
                    type: "post",
                    url: "../FileHandler.ashx?Type=SubCategoryPhoto",
                    data: data,
                    async: false,
                    contentType: false,
                    processData: false,
                    success: function (result) {
                        filepath = result
                    },
                    error: function (err) {
                        var e = err.d;
                        console.log(e);
                    }
                })
            }
            return filepath;
        }
        // On Save
        $("#btnSave").on("click", function () {
            var CategoryID = $("#dllCategory");
            var SubCategoryName = $("#txtSubCategoryName");
            var SubCategoryID = $("#hdnSubCategoryID");
            var SubCategoryPhoto = $("#fuSubCategoryPhoto");
            if (CategoryID.val() == 0) {
                Swal.fire('Invalid Name', 'Provide Category Name', 'error')
                CategoryID.focus();
                return false;

            } else if (SubCategoryName.val() == "") {
                Swal.fire('Invalid Name', 'Provide SubCategory Name', 'error')
                SubCategoryName.focus();
                return false;

            } else if (SubCategoryPhoto.val() == "") {
                Swal.fire('Upload Image', 'Provide Dish Photo', 'error');
                SubCategoryPhoto.focus();
                return false;
            } else {

                var SubCategoryID = SubCategoryID.val() == "" ? 0 : SubCategoryID.val();
                var CategoryID = $("#dllCategory option:selected").val().trim();
                var SubCategoryName = SubCategoryName.val().trim();
                if ($("#fuSubCategoryPhoto").val() != "") {
                    SubCategoryPhoto = SaveImage();
                }
                else {
                    if ($("#hdnPhotoPath").val() != "") {
                        SubCategoryPhoto = $("#hdnPhotoPath").val();
                    }
                    else {
                        Swal.fire('Upload Image', 'Provide Dish Photo', 'error');
                        return false;
                    }
                }
                $.ajax({
                    url: "Webservices/SubCategoryMasterWebService.asmx/SubCategoryMasterManage",
                    method: "POST",
                    data: '{SubCategoryID: ' + JSON.stringify(SubCategoryID) + ',CategoryID: ' + JSON.stringify(CategoryID) + ', SubCategoryName: ' + JSON.stringify(SubCategoryName) + ', SubCategoryPhoto: ' + JSON.stringify(SubCategoryPhoto) + ' }',
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
                                FillSubCategoryData(0);
                            }
                            else {

                                ClearData();
                                Swal.fire('Updated', result, 'success')
                                $("#btnSave").val("Save");
                                FillSubCategoryData(0);
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
        function DeleteSubCategory(SubCategoryID, SubCategoryPhoto) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                background: "#27272a",
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "post",
                        url: "WebServices/SubCategoryMasterWebService.asmx/SubCategoryMasterDelete",
                        data: '{SubCategoryID: ' + JSON.stringify(SubCategoryID) + ',SubCategoryPhoto: ' + JSON.stringify(SubCategoryPhoto) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = response.d;
                            if (result.includes("Error")) {
                                console.log(result);
                            } else {

                                FillSubCategoryData(0);
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
        function EditSubCategory(SubCategoryID) {
            $.ajax({
                url: "Webservices/SubCategoryMasterWebService.asmx/SubCategoryMasterGet",
                method: "POST",
                data: '{SubCategoryID: ' + JSON.stringify(SubCategoryID) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnEditSuccess,
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function OnEditSuccess(response) {

            $("#btnSave").val("Update");
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Details = xml.find("DataDetails");

            $("[id=hdnSubCategoryID]").val(Details.find("SubCategoryID").text());
            $("[id=dllCategory ]").val(Details.find("CategoryID").text());
            $("[id=txtSubCategoryName]").val(Details.find("SubCategoryName").text());
            $("[id=hdnPhotoPath]").val(Details.find("SubCategoryPhoto").text());
            $("[id=imgSubCategoryPhoto]").attr("style", "display:block");
            $("[id=imgSubCategoryPhoto]").prop("src", "../Assets/Images/" + Details.find("SubCategoryPhoto").text());
            $("[id=txtSubCategoryName]").focus();

        }
        // Fill Table
        function FillSubCategoryData(SubCategoryID) {
            $.ajax({
                url: "Webservices/SubCategoryMasterWebService.asmx/SubCategoryMasterGet",
                method: "POST",
                data: '{SubCategoryID: ' + JSON.stringify(SubCategoryID) + ' }',
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
                    var strImage = "";
                    strImage = "<img src=\"../Assets/Images/" + $(this).find("SubCategoryPhoto").text() + "\" style=\"height:100px;width:100px;\">"
                    strEditDelete += "<input id=\"btnEdit\" type=\"button\" value=\"Edit\" onclick=\"EditSubCategory(" + $(this).find("SubCategoryID").text() + ");\" class=\"mx-2 bg-yellow-900 text-white py-3 px-10 hover:bg-yellow-700 cursor-pointer\">";
                    strEditDelete += "<input id=\"btnDelete\" type=\"button\" value=\"Delete\" onclick='DeleteCategory(" + $(this).find("SubCategoryID").text() + ",\"" + $(this).find("SubCategoryPhoto").text() + "\")' class=\"bg-red-900 text-white py-3 px-10 hover:bg-red-700 cursor-pointer\">";

                    table.row.add([
                        $(this).find("RowNumber").text(),
                        $(this).find("CategoryName").text(),
                        $(this).find("SubCategoryName").text(),
                        strImage,
                        strEditDelete
                    ]).draw(false);
                })
            } else {
                table.clear().draw(false);
            }
        }
    </script>
</asp:Content>

