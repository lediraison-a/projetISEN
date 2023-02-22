import {
    defineStore
} from 'pinia'

import { computed, reactive, ref } from 'vue'
import firebase from 'firebase/compat/app'


export const adminUsers = defineStore('users', () => {

    const usersList = ref([])

    const listAllUsers = (nextPageToken) => {
        // List batch of users, 1000 at a time.
        firebase
        .auth()
          .listUsers(1000, nextPageToken)
          .then((listUsersResult) => {
            listUsersResult.users.forEach((userRecord) => {
              console.log('user', userRecord.toJSON());
            });
            if (listUsersResult.pageToken) {
              // List next batch of users.
              listAllUsers(listUsersResult.pageToken);
            }
          })
          .catch((error) => {
            console.log('Error listing users:', error);
          });
      };
      // Start listing users from the beginning, 1000 at a time.
      listAllUsers();

   /*  async function fetchUsers(nextPageToken) {
        // List batch of users, 1000 at a time.
        getAuth()
            .listUsers(1000, nextPageToken)
            .then((listUsersResult) => {
                listUsersResult.users.forEach((userRecord) => {
                    console.log('user', userRecord.toJSON());
                });
                if (listUsersResult.pageToken) {
                    // List next batch of users.
                    listAllUsers(listUsersResult.pageToken);
                }
            })
            .catch((error) => {
                console.log('Error listing users:', error);
            });

    }; */

    return {
        usersList,
        listAllUsers,
    }
})
