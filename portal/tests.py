from django.test import TestCase
from django.urls import reverse


class KillSwitchTest(TestCase):
    def test_no_danger_keyword_in_production(self):
        """
        LOGIQUE DE BLOCAGE :
        - Si 'Attention' est présent -> Le test ÉCHOUE (bloque GitHub).
        - Si 'Attention' est absent -> Le test PASSE (autorise le déploiement).
        """
        response = self.client.get(reverse('home'))

        # On vérifie que la page répond bien
        self.assertEqual(response.status_code, 200)

        # LE VERROU : On affirme que le texte NE DOIT PAS contenir "Attention"
        self.assertNotContains(response, "Attention")
