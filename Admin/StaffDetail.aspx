<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="StaffDetail.aspx.cs" Inherits="Admin_StaffDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="w-full my-5 text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5 shadow-2xl space-y-3">
        <div class="">
            <div>
                <h1 class="text-5xl">Dishes Master</h1>
            </div>
        </div>
        <div class="font-poppins-400 capitalize text-gray-400 font-bold capitalize">
            <div><span class="capitalize">Master > Dishes </span></div>
        </div>
    </div>


    <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
        <div class="w-full">
            <div class="font-poppins-400 text-xl w-full space-y-10 px-5 py-5 font-bold">
                <!-- Image Preview -->
                <div class="grid gap-5 md:grid-cols-2">
                    <div class="flex space-x-5  w-full">
                        <label for="fuStaffPhoto" class="">
                        <img id="imgStaffPhoto" src="#" alt="" height="150" width="150" class="max-w-full h-auto rounded-lg " />
                        <input id="fuStaffPhoto" type="file" class="hidden" />
                            <input id="hdnPhotoPath" type="hidden" class="hidden" />
                    </label>
                    </div>
                    <br />
                    <div class="px-5 justify-center">
                        <label for="imgStaffPhoto">Staff Photo</label>
                    </div>
                </div>
                <!-- Fields -->
                <div class="grid gap-5 md:grid-cols-2  ">
                    
                    <div class="flex space-x-5 w-full ">
                        <lable for="txtStaffName" class="w-1/2 my-auto">Staff Name</lable>
                        <input id="txtStaffName" class="my-4 bg-transparent border w-full border-classic-dimyellow  py-1 px-1" type="text" placeholder="Full Name" />
                    </div>


                    <div class="flex space-x-5 w-full ">
                        <input id="hdnDishID" type="hidden" />
                        <lable for="dllStaffType" class="w-1/2 my-auto">Staff Type </lable>
                        <select id="dllStaffType" class="my-5 mx-auto bg-transparent py-2 px-2 border w-full border-classic-dimyellow text-center" onchange="ListAllSubCategory(this.value)">
                            <option>--SELECT STAFF TYPE --</option>

                        </select>
                    </div>

                   <div class="flex space-x-5 w-full">
                        <lable for="txtMobile" class="w-1/2 my-auto">Mobile No.</lable>
                        <input id="txtMobileNo" class="my-6 bg-transparent border w-full border-classic-dimyellow  py-1 px-1" type="text" />

                    </div>
                    

                    <div class="flex space-x-5 w-full ">
                         <lable for="txtAddress" class="w-1/3 my-auto">Address </lable>
                         <textarea id="txtAddress" class="my-4 bg-transparent border w-full border-classic-dimyellow" cols="20" rows="2"></textarea>
                    </div>

                    

                </div>
                <!-- Fields End-->

                <!-- Buttons -->
                <div class="flex space-x-10">
                    <div class="">
                        <input id="btnSave" class="bg-yellow-900 text-white py-3 px-10 hover:bg-yellow-700 cursor-pointer active:bg-black" type="button" value="Save" />
                    </div>
                    <div>
                        <input id="btnClear" class="border border-yellow-900 text-yellow-900 py-3 px-10 hover:bg-amber-600 hover:text-white cursor-pointer" type="button" value="Clear" />
                    </div>
                </div>
                <!-- Buttons End-->
                <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
                    <table class=" dataTable" id="tblStaffDetail">
                        <thead>
                            <tr>
                               <th>SR.No</th>
                                <th>Staff Type</th>
                                <th>Address</th>
                                <th>Mobile No</th>
                                <th>Staff Photo</th>
                                <th class="flex">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                               <th>SR.No</th>
                                <th>Staff Type</th>
                                <th>Address</th>
                                <th>Mobile No</th>
                                <th>Staff Photo</th>
                                <th class="flex">Actions</th>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th>SR.No</th>
                                <th>Staff Type</th>
                                <th>Address</th>
                                <th>Mobile No</th>
                                <th>Staff Photo</th>
                                <th class="flex">Actions</th>
                            </tr>
                        </tfoot>
                    </table>
                </div>

            </div>
        </div>

    </div>

</asp:Content>

