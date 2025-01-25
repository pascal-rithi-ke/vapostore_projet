<script>
import Carousel from '../components/Carousel.vue';
import GoodPoint from '../components/GoodPoint.vue';
import ProduitType from '../components/ProduitType.vue';

export default {
    components: {
        Carousel,
        GoodPoint,
        ProduitType,
    },
};
</script>

<template>
    <Carousel />
    <div class="mx-40">
        <GoodPoint />
        <ProduitType />
    </div>
</template>
