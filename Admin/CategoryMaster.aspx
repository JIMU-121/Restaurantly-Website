<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="CategoryMaster.aspx.cs" Inherits="Admin_CategoryMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="w-full my-5 text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5 shadow-2xl space-y-3">
        <div class="">
            <div>
                <h1 class="text-5xl">Category Master</h1>
            </div>
        </div>
        <div class="font-poppins-400 capitalize text-gray-400 font-bold capitalize">
            <div><span class="capitalize">Master > Category Master</span></div>
        </div>
    </div>


    <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
        <div class="w-full">
            <div class="font-poppins-400 text-xl w-full space-y-10 font-bold">
                <!-- Image Preview -->
                <div class="grid gap-5 md:grid-cols-2">
                    <div class="flex space-x-5  w-full">
                        <label for="fuCategoryPhoto" class="">
                            <img id="imgCategoryPhoto" src="#" alt="" height="150" width="150" class="max-w-full h-auto rounded-lg " />
                            <input id="fuCategoryPhoto" type="file" class="hidden" />
                            <input id="hdnPhotoPath" type="hidden" class="hidden" />
                        </label>
                    </div>
                    <br />
                    <div class="px-1 justify-center">
                        <label for="imgCategoryPhoto">Category Photo</label>
                    </div>
                </div>
                <!-- Fields -->
                <div class="flex space-x-5 w-full">

                    <lable for="" class="my-auto">Category Name</lable>
                    <input placeholder="--Category Name--" class="bg-transparent  border w-full border-classic-dimyellow w-1/2 py-1 px-1" id="txtCategoryName" type="text" />
                </div>
                <input id="hdnCategoryID" type="hidden" />
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
        <table class=" dataTable" id="tblCategory">
            <thead>
                <tr>
                    <th>SR.No</th>
                    <th>Category Name</th>
                    <th>Category Photo</th>
                    <th class="flex">Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>SR.No</th>
                    <th>Category Name</th>
                    <th>Category Photo</th>
                    <th class="flex">Actions</th>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th>SR.No</th>
                    <th>Category Name</th>
                    <th>Category Photo</th>
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

            table = $("#tblCategory").DataTable({
                responsive: true,
                autoWidth: false,
                'deferRender': true
            });
            FillCategoryData(0);
        })
        // Clear Function
        function ClearData() {
            $("#txtCategoryName").val("");
            $("#hdnCategoryID").val("");
            $("#fuCategoryPhoto").val('');
            $('#imgCategoryPhoto').prop('src', null);
        }
        // Image Function
        $("#fuCategoryPhoto").on("change", function () {
            myfile = $(this).val();
            if (myfile == '') {
                document.getElementById("imgCategoryPhoto").src = "";
                $("#imgCategoryPhoto").attr("style", "display:none");
            }
            var ext = myfile.split('.').pop();
            var str = myfile.substring(0, 10) + "." + ext;
            showFileSize(ext);
        });
        function showFileSize(ext) {
            var input, file;
            var fileUpload = $("#fuCategoryPhoto").get(0);
            input = document.getElementById('fuCategoryPhoto');
            file = fileUpload.files[0];
            var size = parseFloat($("#fuCategoryPhoto")[0].files[0].size / 1024).toFixed(2);

            if (size <= 500) {
                var src = URL.createObjectURL(file);
                var preview = document.getElementById("imgCategoryPhoto");
                preview.src = src;
                preview.style.display = "block";
            }
            else {
                Swal.fire('Size Limit', 'Provide 500kb Photo', 'error');
                $("#fuCategoryPhoto").val('');
            }
        }
        // Save Image
        function SaveImage() {
            var fileUpload = $("#fuCategoryPhoto").get(0);
            var files = fileUpload.files;
            var data = new FormData();
            var filepath = "";
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }

            if (files.length > 0) {
                $.ajax({
                    type: "post",
                    url: "../FileHandler.ashx?Type=CategoryPhoto",
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
        //On Save
        $("#btnSave").on("click", function () {
            var CategoryName = $("#txtCategoryName");
            var CategoryID = $("#hdnCategoryID");
            var CategoryPhoto = $("#fuCategoryPhoto");

            if (CategoryName.val() == "") {
                Swal.fire('Invalid Name', 'Provide Category Name', 'error')
                //alert("Provide Category Name");
                CategoryName.focus();
                return false;
            }
            else if (CategoryPhoto.val() == "") {
                Swal.fire('Upload Image', 'Provide Category Photo', 'error');
                CategoryPhoto.focus();
                return false;
            } else {

                var CategoryID = CategoryID.val() == "" ? 0 : CategoryID.val();
                var CategoryName = CategoryName.val().trim();
                var CategoryPhoto = "";
                if ($("#fuCategoryPhoto").val() != "") {
                    CategoryPhoto = SaveImage();
                }
                else {
                    if ($("#hdnPhotoPath").val() != "") {
                        CategoryPhoto = $("#hdnPhotoPath").val();
                    }
                    else {
                        Swal.fire('Upload Image', 'Provide Category Photo', 'error');
                        return false;
                    }
                }
                $.ajax({
                    url: "Webservices/CategoryMasterWebService.asmx/CategoryMasterManage",
                    method: "POST",
                    data: '{CategoryID: ' + JSON.stringify(CategoryID) + ', CategoryName: ' + JSON.stringify(CategoryName) + ', CategoryPhoto: ' + JSON.stringify(CategoryPhoto) + ' }',
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
                                /*swal("Saved!", result, "success");*/
                                Swal.fire('Saved', result, 'success')
                                FillCategoryData(0);
                            }
                            else {

                                ClearData();
                                Swal.fire('Updated', result, 'success')
                                FillCategoryData(0);
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
        function DeleteCategory(CategoryID,CategoryPhoto) {
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
                        url: "WebServices/CategoryMasterWebService.asmx/CategoryMasterDelete",
                        data: '{CategoryID: ' + JSON.stringify(CategoryID) + ',CategoryPhoto: ' + JSON.stringify(CategoryPhoto) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = response.d;
                            if (result.includes("Error")) {
                                console.log(result);
                            } else {
                                Swal.fire('Deleted!', result, 'success')
                                FillCategoryData(0);
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

        function EditCategory(CategoryID) {
            $.ajax({
                url: "Webservices/CategoryMasterWebService.asmx/CategoryMasterGet",
                method: "POST",
                data: '{CategoryID: ' + JSON.stringify(CategoryID) + ' }',
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

            $("[id=hdnCategoryID]").val(Details.find("CategoryID").text());
            $("[id=txtCategoryName]").val(Details.find("CategoryName").text());
            $("[id=hdnPhotoPath]").val(Details.find("CategoryPhoto").text());
            $("[id=imgCategoryPhoto]").attr("style", "display:block");
            $("[id=imgCategoryPhoto]").prop("src", "../Assets/Images/" + Details.find("CategoryPhoto").text());
            $("[id=txtCategoryName]").focus();

        }
        // Fill Table
        function FillCategoryData(CategoryID) {
            $.ajax({
                url: "Webservices/CategoryMasterWebService.asmx/CategoryMasterGet",
                method: "POST",
                data: '{CategoryID: ' + JSON.stringify(CategoryID) + ' }',
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
                    strImage = "<img src=\"../Assets/Images/" + $(this).find("CategoryPhoto").text() + "\" style=\"height:100px;width:100px;\">"
                    strEditDelete += "<input id=\"btnEdit\" type=\"button\" value=\"Edit\" onclick=\"EditCategory(" + $(this).find("CategoryID").text() + ");\" class=\"mx-2 bg-yellow-900 text-white py-3 px-10 hover:bg-yellow-700 cursor-pointer\">";
                    strEditDelete += "<input id=\"btnDelete\" type=\"button\" value=\"Delete\" onclick='DeleteCategory(" + $(this).find("CategoryID").text() + ",\"" + $(this).find("CategoryPhoto").text() +"\")' class=\"bg-red-900 text-white py-3 px-10 hover:bg-red-700 cursor-pointer\">";

                    table.row.add([
                        $(this).find("RowNumber").text(),
                        $(this).find("CategoryName").text(),
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

