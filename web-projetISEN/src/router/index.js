import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import DownloadView from '../views/DownloadView.vue'
import UserView from '../views/UserView.vue'
import QuestionsAnswers from '../views/QuestionsAnswers.vue'
import SignIn from '../components/SignIn.vue'
import Admin from '../views/AdminView.vue'
import Contact from '../views/Contact.vue'
import NotFoundView from '../views/NotFoundView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/user',
      name: 'user',
      component: UserView,
    },
    {
      path: '/admin',
      name: 'admin',
      component: Admin,
    },
    {
      path: '/download',
      name: 'download',
      component: DownloadView,
    },
    {
      path: '/signin',
      name: 'signin',
      component: SignIn,
    },
    {
      path: '/qna',
      name: 'qna',
      component: QuestionsAnswers,
    },
    {
      path: '/contact',
      name: 'contact',
      component: Contact
    },
    { path: '/:pathMatch(.*)*', name: 'not-found', component: NotFoundView },
  ],
})

export default router
