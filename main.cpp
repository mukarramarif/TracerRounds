// TracerRounds_Project.cpp : Defines the entry point for the application.
//

#include "main.h"

using namespace std;

int main()
{
	try {
		// Initialize GLFW
		if (!glfwInit()) {
			throw std::runtime_error("Failed to initialize GLFW");
		}

		// Create Vulkan instance
		VkInstanceCreateInfo createInfo{};
		createInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
		
		VkInstance instance;
		if (vkCreateInstance(&createInfo, nullptr, &instance) != VK_SUCCESS) {
			throw std::runtime_error("Failed to create Vulkan instance");
		}

		// Clean up
		vkDestroyInstance(instance, nullptr);
		glfwTerminate();
		
		return 0;
	} catch (const std::exception& e) {
		std::cerr << e.what() << std::endl;
		return -1;
	}
}
