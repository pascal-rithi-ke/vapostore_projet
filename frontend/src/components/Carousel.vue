<template>
    <div class="relative w-full overflow-hidden">
        <!-- Carousel Container -->
        <div
            class="flex transition-transform duration-700 ease-in-out"
            :style="{ transform: `translateX(-${currentIndex * 100}%)` }"
        >
            <div
                v-for="(slide, index) in slides"
                :key="index"
                class="flex-shrink-0 w-full h-[300px] sm:h-[400px] md:h-[500px] lg:h-[600px] flex items-center justify-center"
            >
                <img
                    :src="slide.image"
                    class="w-full h-full object-contain"
                />
            </div>
        </div>

        <!-- Indicators -->
        <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2">
            <button
                v-for="(slide, index) in slides"
                :key="index"
                class="w-3 h-3 rounded-full"
                :class="currentIndex === index ? 'bg-white' : 'bg-gray-400'"
                @click="goToSlide(index)"
            ></button>
        </div>

        <!-- Navigation Buttons -->
        <button
            class="carousel-button carousel-button-left"
            @click="goToPreviousSlide"
        >
            <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="2"
                stroke="currentColor"
                class="w-5 h-5 md:w-6 md:h-6"
            >
                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M15 19l-7-7 7-7"
                />
            </svg>
        </button>
        <button
            class="carousel-button carousel-button-right"
            @click="goToNextSlide"
        >
            <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="2"
                stroke="currentColor"
                class="w-5 h-5 md:w-6 md:h-6"
            >
                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M9 5l7 7-7 7"
                />
            </svg>
        </button>
    </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, onUnmounted } from 'vue';

import carouselImage1 from '../assets/carousel-1.jpg';
import carouselImage2 from '../assets/carousel-2.jpg';
import carouselImage3 from '../assets/carousel-3.jpg';

export default defineComponent({
    name: 'AdjustableHeightCarousel',
    setup() {
        const slides = ref([
            { title: 'Slide 1', image: carouselImage1 },
            { title: 'Slide 2', image: carouselImage2 },
            { title: 'Slide 3', image: carouselImage3 },
        ]);

        const currentIndex = ref(0);

        const goToSlide = (index: number) => {
            currentIndex.value = index;
        };

        const goToNextSlide = () => {
            currentIndex.value = (currentIndex.value + 1) % slides.value.length;
        };

        const goToPreviousSlide = () => {
            currentIndex.value =
                (currentIndex.value - 1 + slides.value.length) % slides.value.length;
        };

        const startAutoScroll = () => {
            return setInterval(() => {
                goToNextSlide();
            }, 3000);
        };

        let intervalId: number | null = null;

        onMounted(() => {
            intervalId = startAutoScroll();
        });

        onUnmounted(() => {
            if (intervalId !== null) {
                clearInterval(intervalId);
            }
        });

        return {
            slides,
            currentIndex,
            goToSlide,
            goToNextSlide,
            goToPreviousSlide,
        };
    },
});
</script>

<style scoped>
.carousel-button {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    padding: 10px;
    border-radius: 50%;
    cursor: pointer;
    z-index: 10;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s ease;
}

.carousel-button:hover {
    background-color: rgba(255, 255, 255, 0.8);
    color: black;
}

.carousel-button-left {
    left: 10px;
}

.carousel-button-right {
    right: 10px;
}

@media (max-width: 768px) {
    .carousel-button {
        padding: 8px;
    }

    .carousel-button svg {
        width: 20px;
        height: 20px;
    }
}
</style>
