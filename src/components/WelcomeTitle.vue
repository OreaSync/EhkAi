<template>
    <div v-if="isVisible" class="w-full h-full z-50 fixed backdrop-blur-md">
        <div class="flex flex-col justify-center items-center p-4 mt-20">
            <div class="bg-[#1a1919] p-4 text-center rounded-xl w-[30%] mb-2">
                <h1 class="text-4xl">EhkAi</h1>
                <p class="text-2xl">Hello, this site is designed for using neural networks. Please keep in mind that <span class="text-[#FFB88C]">neural networks do not have memory</span>; each new question is a new request to the neural network. If you find a bug or an issue, please report it to <a class="underline" href="https://t.me/PinkFlowerDelivery">OreoSync</a>.</p>
            </div>
            <button @mouseleave="understandButtonEnterLeave" @mouseenter="understandButtonEnterAnim" ref="understandButton" class="px-3 py-2 text-[#FFB88C] bg-[#111111] border-[#1b1b1bec] text-[20px] border-2 rounded-xl" @click="isVisible = false">I understand.</button>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import gsap from 'gsap';

const isVisible = ref(true);
const understandButton = ref(null);

const understandButtonEnterAnim = () => {
    gsap.to(understandButton.value, { scale: 0.95 });
}

const understandButtonEnterLeave = () => {
    gsap.to(understandButton.value, { scale: 1, duration: 0.3 });
}

</script>