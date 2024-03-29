import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import DownloadView from '../views/DownloadView.vue'
import UserView from '../views/UserView.vue'
import QuestionsAnswers from '../views/QuestionsAnswers.vue'
import SignIn from '../components/SignIn.vue'
import Admin from '../views/AdminView.vue'
import Contact from '../views/ContactView.vue'
import NotFoundView from '../views/NotFoundView.vue'
import { useUserContext } from '@/stores/userContextStore'
import { useAdmin } from '@/stores/adminStore'
import firebase from 'firebase/compat/app'

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
      component: Contact,
    },
    { path: '/:pathMatch(.*)*', name: 'not-found', component: NotFoundView },
  ],
})

const protectedPath = ['user', 'admin', 'download']
const adminPath = ['admin']

router.beforeEach(async (to, from) => {
  const userContext = useUserContext()
  const adminStore = useAdmin()

  // admin path guard
  if (adminPath.includes(to.name) && to.name !== 'not-found') {
    await userContext.getCurrentUser()
    if (!userContext.isConnected) {
      return { name: 'not-found' }
    }
    await adminStore.fetchIsSelfAdmin()
    if (!adminStore.isSelfAdmin) {
      return { name: 'not-found' }
    }
  }

  // user path guard
  if (
    protectedPath.includes(to.name) &&
    !userContext.isConnected &&
    to.name !== 'signin'
  ) {
    await userContext.getCurrentUser()
    if (!userContext.isConnected) {
      return { name: 'signin' }
    }
  }
})

export default router
