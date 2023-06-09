﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ClientMasterPage.master" AutoEventWireup="true" CodeFile="Menu.aspx.cs" Inherits="Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="h-full bg-restaurantly-brown text-white">
        <div class="flex  justify-center py-10">
            <div class="w-full mx-5 text-classic-yellow">
                <!-- Section Title -->
                <div class="section-title my-16 space-y-5 w-full justify-start w-full md:mx-20 lg: xl:mx-32 2xl:mx-64 my-10">
                    <h2 class="title font-semibold text-gray-400 ">M E N U</h2>
                    <p class="font-playfair-display-700 text-5xl">Choose Your Category</p>
                </div>
                <!-- Section Title End-->

                <!-- Filters End-->
                <div class="flex filters justify-center cursor-pointer " id="CategoryMenu">
                    <div>
                        <ul class="flex text-xl font-playfair-display-600 space-x-10  ">
                            <li class="cursor-pointer">All</li>
                            <li class="cursor-pointer">Starters</li>
                            <li class="cursor-pointer">Salads</li>
                            <li class="cursor-pointer">Specially</li>
                        </ul>
                    </div>
                </div>
                <!-- Filters End-->

                <!-- Category List -->
                <div class="text-white menu-list">
                    <div class="grid xl:grid-cols-3 md:grid-cols-2  md:mx-20 lg: xl:mx-32 2xl:mx-64 my-10">

                        <div class=" my-5 space-x-3">
                            <div>
                                <div class="border-4 w-28  border-gray-500 rounded-full ">
                                    <img alt="Dish" height="100px" class="w-full" src="Template/img/specials-3.png" />
                                </div>
                            </div>
                            <div class="w-full">
                                <div class="font-bold  flex  justify-between ">
                                    <a>Manchurian Soup</a>
                                </div>
                                <div class="text-sm text-gray-400 font-semibold">
                                    <span>Noodels, Spcies,Green chili paste</span>
                                </div>
                            </div>
                        </div>
                        <%--<div class="flex my-5 space-x-3">
                            <div class="border-4 border-gray-500 rounded-full ">
                                <img alt="Dish" height="100px" width="100px" src="Template/img/specials-3.png" />
                            </div>
                            <div class="w-full">
                                <div class="font-bold  flex  justify-between ">
                                    <a>Manchurian Soup</a>
                                </div>
                                <div class="text-sm text-gray-400 font-semibold">
                                    <span>Noodels, Spcies,Green chili paste</span>
                                </div>
                            </div>
                        </div>
                        <div class="flex my-5 space-x-3">
                            <div class="border-4 border-gray-500 rounded-full ">
                                <img alt="Dish" height="100px" width="100px" src="Template/img/specials-3.png" />
                            </div>
                            <div class="w-full">
                                <div class="font-bold  flex  justify-between ">
                                    <a>Manchurian Soup</a>
                                </div>
                                <div class="text-sm text-gray-400 font-semibold">
                                    <span>Noodels, Spcies,Green chili paste</span>
                                </div>
                            </div>
                        </div>
                        <div class="flex my-5 space-x-3">
                            <div class="border-4 border-gray-500 rounded-full ">
                                <img alt="Dish" height="100px" width="100px" src="Template/img/specials-3.png" />
                            </div>
                            <div class="w-full">
                                <div class="font-bold  flex  justify-between ">
                                    <a>Manchurian Soup</a>
                                </div>
                                <div class="text-sm text-gray-400 font-semibold">
                                    <span>Noodels, Spcies,Green chili paste</span>
                                </div>
                            </div>
                        </div>
                        <div class="flex my-5 space-x-3">
                            <div class="border-4 border-gray-500 rounded-full ">
                                <img alt="Dish" height="100px" width="100px" src="Template/img/specials-3.png" />
                            </div>
                            <div class="w-full">
                                <div class="font-bold  flex  justify-between ">
                                    <a>Manchurian Soup</a>
                                </div>
                                <div class="text-sm text-gray-400 font-semibold">
                                    <span>Noodels, Spcies,Green chili paste</span>
                                </div>
                            </div>
                        </div>--%>
                    </div>
                </div>
                <!-- Menu List End-->

            </div>
        </div>
    </section>
    <script>
        $(function () {
            FillCategoryMenu();
        })

        function FillCategoryMenu() {
            $.ajax({
                url: "Admin/Webservices/CategoryMasterWebService.asmx/CategoryMasterGet",
                method: "POST",
                data: "{CategoryID:0}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                async: false,
                error: function (err) {
                    console.log(err);
                }

            });
        }


        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Details = xml.find("DataDetails");

            var divTag = "";

            if (Details.length > 0) {
                $.each(Details, function () {
                    
                    divTag += `
                    <div>
                        <label for="Categoryfu" class="w-10 flex-space-x-5 px-5 justify-left">
                            <img alt="Category" height="50px" width="50px" class="w-full" src= "Assets/Images/`+ $(this).find("CategoryPhoto").text() + `" />
                        </label>
                        <input id="Categoryfu" type="button" class="hidden" />
                        
                    </div>
                    `;
                })
            }
            else {

            }
            $("#CategoryMenu").html(divTag)
        }
    </script>
</asp:Content>

