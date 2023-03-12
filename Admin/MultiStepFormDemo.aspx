<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="MultiStepFormDemo.aspx.cs" Inherits="Admin_MultiStepFormDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="text-classic-yellow font-playfair-display-500 bg-classic-brown py-5 px-5 shadow-2xl space-y-3">
        <div class="container flex flex-col flex-wrap px-5 py-4 mx-auto">
            <div class="flex flex-wrap mx-auto">
                <a
                    class="
              inline-flex
              items-center
              justify-center
              w-1/2
              py-3
              font-medium
              leading-none
              tracking-wider
              text-indigo-500
              
              
              rounded-t
              sm:px-6 sm:w-auto sm:justify-start
              title-font
            ">STEP 1
                </a>
                <a
                    class="
              inline-flex
              items-center
              justify-center
              w-1/2
              py-3
              font-medium
              leading-none
              tracking-wider
              
              sm:px-6 sm:w-auto sm:justify-start
              title-font
              hover:text-gray-900
            ">STEP 2
                </a>
                <a
                    class="
              inline-flex
              items-center
              justify-center
              w-1/2
              py-3
              font-medium
              leading-none
              tracking-wider
             
              sm:px-6 sm:w-auto sm:justify-start
              title-font
              hover:text-gray-900
            ">STEP 3
                </a>
            </div>
            <div class="flex flex-col w-full text-center">
                <div class="py-6  sm:py-8 lg:py-12">
                    <div class="px-4 mx-auto max-w-screen-2xl md:px-8">
                        <div class="grid gap-5 md:grid-cols-2">
                            <div class="flex space-x-5  w-full">
                                <label for="fuDishPhoto" class="">
                                    <img id="imgDishPhoto" src="#" alt="" height="150" width="150" class="max-w-full h-auto rounded-lg " />
                                    <input id="fuDishPhoto" type="file" class="hidden" />
                                    <input id="hdnPhotoPath" type="hidden" class="hidden" />
                                </label>
                            </div>
                            <br />
                            
                        </div>
                        <div>
                            <br />
                        </div>
                        <!-- form - start -->
                        <div class="max-w-screen-md mx-auto">
                            <div class="flex flex-col mb-4">
                                <label
                                    for="txtDishName"
                                    class="inline-flex w-full my-auto">
                                    First Name</label>
                                <input
                                    name="txtDishName"
                                    class="
                      w-full
                      px-3
                      py-2
                      bg-transparent border w-full border-classic-dimyellow  py-1 px-1
                    " />
                            </div>



                            <div class="flex items-center justify-between">
                                <button
                                    class="
                      border border-yellow-900 text-yellow-900 py-3 px-10 hover:bg-amber-600 hover:text-white cursor-pointer
                    ">
                                    Back
                                </button>
                                <button class="bg-yellow-900 text-white py-3 px-10 hover:bg-yellow-700 cursor-pointer active:bg-black">Next</button>
                            </div>
                        </div>
                        <!-- form - end -->
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

