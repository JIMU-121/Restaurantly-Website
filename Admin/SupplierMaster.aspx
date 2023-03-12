<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="SupplierMaster.aspx.cs" Inherits="Admin_SupplierMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="w-full my-5 text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5 shadow-2xl space-y-3">
        <div class="">
            <div>
                <h1 class="text-5xl">Supplier Master</h1>
            </div>
        </div>
        <div class="font-poppins-400 capitalize text-gray-400 font-bold capitalize">
            <div><span class="capitalize">Inventory > Supplier Master</span></div>
        </div>
    </div>


    <div class="w-full my-5 shadow-2xl text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5">
        <div class="w-full">
            <div class="font-poppins-400 text-xl w-full space-y-10 font-bold">

                <!-- Fields -->
                <div class="grid gap-5 md:grid-cols-2 lg:grid-cols-2">
                    <div class="flex space-x-5 w-full ">
                        <lable for="txtSupplierName" class="w-1/3 my-auto">Supplier Name </lable>

                        <input id="txtSupplierName" placeholder="" class="my-10 bg-transparent border w-full border-classic-dimyellow  px-1"  type="text" />
                       
                    </div>

                     <div class="flex space-x-5 ">

                        <lable for="txtEmail" class="w-1/3 my-auto">EmailID </lable>

                        <input id="txtEmail" placeholder="" class="my-10 bg-transparent border w-full border-classic-dimyellow  py-1 px-1"  type="text" />
                    </div>
                    <div class="flex space-x-5 w-full">

                        <lable for="txtContactNo" class="w-1/3 my-auto">Contact No </lable>

                        <input id="txtContactNo" placeholder="" class="my-4 bg-transparent border font-thin w-full border-classic-dimyellow  py-1 px-1"  type="text" />
                    </div>
                     <div class="flex space-x-5 w-full">

                        <lable for="txtContactPerson" class="w-1/3 my-auto">Contact Person </lable>

                        <input id="txtContactPerson" placeholder="example:- Slicer, Mixer" class="my-4 bg-transparent border font-thin w-full border-classic-dimyellow py-1 px-1"  type="text" />
                    </div>
                    <div class="flex space-x-5 ">

                        <lable for="txtEmail" class="w-1/3 my-auto">GST</lable>

                        <input id="txtGSTNo" placeholder="" class="my-10 bg-transparent border w-full border-classic-dimyellow  py-1 px-1"  type="text" />
                    </div>
                     <div class="flex space-x-5 w-full">

                        <lable for="TextAreaAddress" class="w-1/3 my-auto">Address </lable>
                         <textarea id="TextAreaAddress" class="my-6 bg-transparent border w-full border-classic-dimyellow" cols="20" rows="2"></textarea>
                        <%--<input id="txtAddress" placeholder="example:- Slicer, Mixer" class="bg-transparent border font-thin w-full border-classic-dimyellow w-1/2 py-1 px-1"  type="text" />--%>
                    </div>
                </div>

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

</asp:Content>

